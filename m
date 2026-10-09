Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF74E80A5;
	Fri,  9 Oct 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567040; cv=none; b=UC7w6SIeHvWWezg3qY0VHMVAWnQD9eAMBN9Bjh2YhRKtBdfP0pKgaDGTtsxoA2izDxdEN6vMP/6r1OLh8IOvyVeSTozkBmCQwNgPko0LvnZBPYBg8K1uDeZ1/IWAwzRNZCSBHI9AnisY8J3IdGWaztQZImkQBFLsfS9nF2j3Xk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567040; c=relaxed/simple;
	bh=ZMUkT3HCnoAv+4zY/mgtMgENsdzx/g2lCUs3yVSSvBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E7SNa5jzVx9JMut4n5gVRsNyf/KENUiJalodlTmx/ovDc6opFK2c40qP7ZbF1Kil+2y9433FnBxWjZJn3BN47dcnPFQTx8LpGOaSwqNbk8E+/MuWZ+PDymqZmKAnW995IVG8CBNhaYtQTOOcxcC/dswbQwytG9ORnuOXKatxgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWKiodC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWKiodC5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C493C2BCF7;
	Fri,  9 Oct 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791567040;
	bh=ZMUkT3HCnoAv+4zY/mgtMgENsdzx/g2lCUs3yVSSvBQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WWKiodC5e4ghUoUwF+5Ca2DKLkRxp/w/zQ0/o3azzlU2e6mmFppUyqxW6Vx9aBcnl
	 xEY+n7pDCFOCcJgq+1MqtANxaEXfOJkwD6q/G4x0HIMjMtuVMrAUkJpK87zea4RAjS
	 hG1PwIY6NfrPgGjnVbc/WvSQtZFevj6qNqDatp34llbWngeWOR2I6OWRXhy7OcLCpq
	 U+aR0njALsXENmDFbxqu1LpkFLpxbm6JGny+4+bEuBGYXYR6rQpMC6v7UPboAhLDS4
	 KhePY4xvHO6e96VLS/wIzUD97AjmQEuB9HO6AIC3a8x9sgOzeDn7PUOxfrhHw7CrMs
	 yvnLnj3FOu1GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47441CA9EBD;
	Fri,  9 Oct 2026 17:30:40 +0000 (UTC)
From: George Melikov via B4 Relay <devnull+mail.gmelikov.ru@kernel.org>
Date: Fri, 09 Oct 2026 20:30:18 +0300
Subject: [PATCH net] bnx2x: fix header length calculation for encapsulated
 TSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-bnx2x-tso-fix-v1-1-1ebea422422d@gmelikov.ru>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBQFf6WctReSUOrjV8SFbY56XaSSGyVQ+
 u+mupyBmQXGrDScugWZHzWdUwO/6zA9rulO0dgYwYXBO3eUMdVQpdgsN62y96E/kDEy9mjNK7P
 p3++MxILLX9p7fHIq2wnr+gUiSnhYdgAAAA==
X-Change-ID: 20261009-bnx2x-tso-fix-71248eedded4
To: Sudarsana Kalluru <skalluru@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Melikov <mail@gmelikov.ru>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791567039; l=4687;
 i=mail@gmelikov.ru; s=20261009; h=from:subject:message-id;
 bh=ib/39jw33W1R/Lg8gpoZ4DSHupU4qDJZI1uVBbkX47A=;
 b=JmfWZUwvA70a/3wdHjWvCBxSbUCHBv5KD1dd5EG4EVkqh2qhj0OelfbTiMx9BeNEvuyX+zYEC
 ReLptwE02zyCWC/t9IPUHNPj3qjHZ41q3+bvbIR6UgFtxrM3rgznTcP
X-Developer-Key: i=mail@gmelikov.ru; a=ed25519;
 pk=xCsTDos5FfVToMVLadCYgzlG5s7URKW+/wYyiEx1zxk=
X-Endpoint-Received: by B4 Relay for mail@gmelikov.ru/20261009 with
 auth_id=1145
X-Original-From: George Melikov <mail@gmelikov.ru>
Reply-To: mail@gmelikov.ru

From: George Melikov <mail@gmelikov.ru>

Commit 80bfab79b835 ("net: adopt skb_network_offset() and similar helpers")
replaced the difference between the inner transport header and the outer
network header with skb_inner_transport_offset().
The helper is relative to skb->data, so the new calculation incorrectly
includes the outer Ethernet header in fw_ip_hdr_to_payload_w.

On a BCM57810 transmitting TCP over VXLAN with an outer MTU of 1500,
hardware segmentation emits packets declaring an outer IPv4 total length
of 1514 while the actual IP packet is only 1500 bytes long. The receiver
drops these malformed packets, severely degrading TCP connectivity.

Subtract skb_network_offset() to restore the original calculation of the
length from the outer network header to the inner TCP payload.

Reproduced with plain kernel VXLAN and one TCP flow on kernel
7.0.0-31-generic: 50 of 200 captured packets had an invalid outer IP length
with the original driver, versus none with this fix. Disabling TSO/GSO on
the test VXLAN device also eliminated the error with the original driver.

Fixes: 80bfab79b835 ("net: adopt skb_network_offset() and similar helpers")
Signed-off-by: George Melikov <mail@gmelikov.ru>
Assisted-by: LLM
---
Minimal reproducer: two physical Linux hosts and plain kernel VXLAN.
Sender: BCM57810, affected bnx2x, TCP and UDP tunnel segmentation enabled.
Receiver need not use bnx2x. Underlay MTU 1500, VXLAN MTU 1450.
Run commands in a root Bash shell.

On A:

    LOCAL=192.168.1.185 REMOTE=192.168.1.102 DEV=eno1 TEST=198.18.77.1

On B (underlay IP on br0, physical NIC eno1):

    LOCAL=192.168.1.102 REMOTE=192.168.1.185 DEV=br0 TEST=198.18.77.2

On both:

    ip netns add bnx-repro
    ip link add bnxvx type vxlan id 160009 local "$LOCAL" remote "$REMOTE" dev "$DEV" dstport 4790 nolearning
    ip link set bnxvx netns bnx-repro
    ip -n bnx-repro addr add "${TEST}/30" dev bnxvx
    ip -n bnx-repro link set lo up
    ip -n bnx-repro link set bnxvx mtu 1450 up

On A, verify TSO/GSO and TX checksumming are on for eno1 and bnxvx,
and tx-udp_tnl-segmentation is on for eno1:

    ethtool -k eno1
    ip netns exec bnx-repro ethtool -k bnxvx

On B, first terminal:

    ip netns exec bnx-repro iperf3 -s -B 198.18.77.2 -p 35219

On B, second terminal: verify rx-gro-hw and LRO are off. These commands
assume software GRO was initially on; restore it after capture, including
if interrupted. If initially off, leave it off.

    ethtool -k eno1
    ethtool -K eno1 gro off
    timeout --signal=INT 30 tcpdump -U -ni eno1 -s 0 -c 200 \
        -w /tmp/bnx2x-repro.pcap \
        'ip and udp dst port 4790 and src host 192.168.1.185'
    ethtool -K eno1 gro on

Once tcpdump reports "listening on eno1", run on A:

    timeout 12 ip netns exec bnx-repro iperf3 -c 198.18.77.2 -p 35219 -t 3 -P 1 -J

Read the capture on B:

    tcpdump -T vxlan -nn -vv -r /tmp/bnx2x-repro.pcap

Malformed outer IP length, depending on tcpdump version:

    4.99.4: IP truncated-ip - 14 bytes missing! (... length 1514)
    4.99.6: IP [total length 1514 > length 1500] (invalid)

The complete frame contains only 1500 IP bytes; the header declares 1514.

Control: on A, disable TSO/GSO on the test device; repeat capture with a
new filename and rerun the client. Restore both flags afterwards:

    ip netns exec bnx-repro ethtool -K bnxvx tso off gso off
    # Repeat capture and client, then:
    ip netns exec bnx-repro ethtool -K bnxvx tso on gso on

Observed on 7.0.0-31-generic/BCM57810: original hardware TSO 50/200 bad
packets, software segmentation 0/200, fixed hardware TSO 0/200.
Counts may vary. These short runs are functional checks, not benchmarks.

Cleanup: stop iperf3, then on both hosts:

ip netns del bnx-repro
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5a9742fd3..6fb061973 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3666,7 +3666,8 @@ static void bnx2x_update_pbds_gso_enc(struct sk_buff *skb,
 	u8 outerip_off, outerip_len = 0;
 
 	/* from outer IP to transport */
-	hlen_w = skb_inner_transport_offset(skb) >> 1;
+	hlen_w = (skb_inner_transport_offset(skb) -
+		  skb_network_offset(skb)) >> 1;
 
 	/* transport len */
 	hlen_w += inner_tcp_hdrlen(skb) >> 1;

---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20261009-bnx2x-tso-fix-71248eedded4

Best regards,
--  
George Melikov <mail@gmelikov.ru>


