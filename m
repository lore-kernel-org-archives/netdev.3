Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9193E4C87;
	Wed,  3 Jun 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474243; cv=none; b=d14W37v5D9n91iNQXfWlD0P+s70xGa1PKkQ0mj/N/FPhhr12Ik5hEhNK0B4PDdBdYcHnq6Bca5SQRnSLYm9E1/lwo3O63mRNFeES3AZHrPFYRJ9t/IANQq18oNwtGu+aNJzXKf2sigWR3nII/N+7sAJnKHd8XAaEPYx7Zsz0HqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474243; c=relaxed/simple;
	bh=/ivuoXmn0fGk94Wrm9o0gp9RqayVVXejm1nXpv/p7M4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKCnIcI0NYWdoLCJln/HkuHqZp1xu76Al1qAs7ZY+V8MnLef32YnXZ0CXmqJY27WPM6kW8GXbu3UrSS8Y8IX/79/RmEKNl34s3+vvuf2+sc7r8sUeTh1WWi1OVx/VtVKp3NSAI9jvUqrHdgQU/vbJ5msBhPOGAmZad+lz/9T5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=PwY4hvg/; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="PwY4hvg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=cCw1q
	w/oroUNjjOalZ1iZ0UFmPB41in0T8IagR03HaE=; b=PwY4hvg/IbkKEocaA9jjy
	RiFQE2IY1LnhIhMBIv0IzdG7K79N2bWNVOD2V0s75syaX2NRIXpN7oFTRY4CBYHT
	4NhFYkodeoEkDrW59Fr3G9Gm9eAofeVpzVCsZytmljD9XmTIBuo0zYs0cHZBuPeH
	R252zAIW3y/oAmB8P0RfKY=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web3 (Coremail) with SMTP id ygQGZQCn8o9w4R9qLjAjAg--.35845S2;
	Wed, 03 Jun 2026 16:10:25 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH v2 net] vlan: fix REORDER_HDR race between header and xmit paths
Date: Wed,  3 Jun 2026 16:10:17 +0800
Message-ID: <20260603081018.23901-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCn8o9w4R9qLjAjAg--.35845S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy3uFy7XrWfGry7Kw4kZwb_yoWrAFWrpa
	1UKFZ8CFWDXr9av3yqqw45GF4UJF4kJay7Ca4DGryUZw15XFyxZrZ7Kas3Ar4qqFZxKr1U
	ZF9rZr45C3WkGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjXTm3UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQQHAWofuXJz-AAAsy

vlan_dev_change_flags() updates vlan->flags under RTNL, but the VLAN
data path reads the same field without RTNL.  In particular,
vlan_dev_hard_header() and vlan_dev_hard_start_xmit() may observe
different values of VLAN_FLAG_REORDER_HDR for the same skb.

This can lead to inconsistent tagging.  If REORDER_HDR is cleared when
vlan_dev_hard_header() runs, the function pushes an in-band VLAN header
into the skb.  If REORDER_HDR is then observed as set by
vlan_dev_hard_start_xmit(), the xmit path may also attach a hardware
accelerated VLAN tag, causing the packet to be emitted with two VLAN
tags.  Conversely, if the flag changes in the other direction, the skb
may be emitted without the expected VLAN tag.

Avoid making the xmit decision depend on a second unsynchronized read of
vlan->flags.  Instead, use skb->protocol which was set to vlan->vlan_proto
by vlan_dev_hard_header() when it pushed a VLAN header (REORDER_HDR off),
or left as the encapsulated protocol otherwise (REORDER_HDR on).
Checking skb->protocol first also preserves the short-circuit evaluation
order introduced by commit dacab578c7c6c ("vlan: fix a potential
uninit-value in vlan_dev_hard_start_xmit()"): when no VLAN header was
pushed, skb->protocol != vlan->vlan_proto is true and veth->h_vlan_proto
is not read, avoiding the uninit-value issue.

Also use READ_ONCE() for the data-path read in vlan_dev_hard_header()
and WRITE_ONCE() for the control-path update in vlan_dev_change_flags().

Fixes: 6ab3b487db77 ("[VLAN]: Fix nested VLAN transmit bug")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
Changes in v2:
- Replace `vlan->flags & VLAN_FLAG_REORDER_HDR` with `skb->protocol != vlan->vlan_proto`
  in xmit.  v1 used `veth->h_vlan_proto != vlan->vlan_proto` alone, which
  re-introduced the uninit-value bug fixed by commit dacab578c7c6c ("vlan:
  fix a potential uninit-value in vlan_dev_hard_start_xmit()"): when
  REORDER_HDR is on, vlan_dev_hard_header() does not push a VLAN header and
  veth->h_vlan_proto may reference uninitialized data.  skb->protocol avoids
  this because vlan_dev_hard_header() sets it to vlan->vlan_proto only when
  it pushes a VLAN header (REORDER_HDR off), preserving the short-circuit.
- Add Fixes: tag to 6ab3b487db77 ("[VLAN]: Fix nested VLAN transmit bug"),
  the commit that first introduced the vlan->flags read in xmit.
- Link to v1: https://lore.kernel.org/netdev/20260529073004.77147-1-zhaoyz24@mails.tsinghua.edu.cn/
---
 net/8021q/vlan_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -54,7 +54,7 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 	u16 vlan_tci = 0;
 	int rc;

-	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+	if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
 		vhdr = skb_push(skb, VLAN_HLEN);

 		vlan_tci = vlan->vlan_id;
@@ -110,7 +110,7 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
 	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
 	 */
-	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
+	if (skb->protocol != vlan->vlan_proto ||
 	    veth->h_vlan_proto != vlan->vlan_proto) {
 		u16 vlan_tci;
 		vlan_tci = vlan->vlan_id;
@@ -226,7 +226,7 @@ int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
 		     VLAN_FLAG_BRIDGE_BINDING))
 		return -EINVAL;

-	vlan->flags = (old_flags & ~mask) | (flags & mask);
+	WRITE_ONCE(vlan->flags, (old_flags & ~mask) | (flags & mask));

 	if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
 		if (vlan->flags & VLAN_FLAG_GVRP)

