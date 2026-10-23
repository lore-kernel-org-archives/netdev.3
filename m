Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746964;
	b=qoJudT+w3K9K8jH1W0Yf6lDPuBwa/M+P/sGdjcMjM/wHS+GETaI+qPVmJ4vds9erchLY
	 ejlg6Eiwnt184klAKBT3ubl5h4MkbV6t+17mbsN4Arb+OOVweDfVidjxqkn+3XTGT1izQ
	 IrbXYUEWScWyq6BeA/XPh6UXD7q175ugyC1Z9ONdvL4ckbOtKlTKFtu3npNm2OJ4cTNEJ
	 8gc9rRIKytUO4Ws6yQBNM8Wc8znBzh8eDzDq2voDNTOxG+w2UwrguMnWUI35/uepnfuZr
	 MdeO2h9DyV5f1GWriNxw0VAGkzC/Omgnwq2XJ3vPBc2khPswhi37BVaMNhEhcbCcYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746964;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gQa3VPH3WC7Q6OeX84J4Qisj2fpU7RPLlHn2HbeI82U=;
	b=HaETDEWErPh0lR+gaS5Jey+QkTkd4sNbDIULvA90o5R66Lrwh4MnH9GAGFSB0MPG4TgQ
	 YKUC/HEhf4VoF6sxZca1+lp+1bIcQc5/VZEXWC1jVD5uEMfQGfXcKxD6FzJ8JdiiQ6jwb
	 ixF96/vy3xUHlXqZLtqAHubQRinJQ0wq2Re5DsPA8O5DnJgc6jqv35mgwzMIzcgHyAZgK
	 wL/KZw2FdFc5oBpsH/MND1WAl91kaTJ0l+MSc65O1qtEYBAsKnzAY37YPm9S69u3YXXlI
	 +NQLz5X51ckpnoHPZkzCz/lCESUbRhM2Fcg0jwjxlyA9Q8FVKrWUWPN7sAjPTtC1Rbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YVMKHM67;
	arc=none smtp.remote-ip=91.218.175.9
Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D6606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669D6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YVMKHM67
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AXpBt4cHsmJnsrGVNmAyGambJ4dbgF80uBFZxZfStYY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746961; v=1; x=1793351761;
 b=YVMKHM67oBkq21ZxQ9lCVhFNPOfVj13dMAaMtxP/6qDup5nOQcW+SMWBGGKLAddRixqoc2Hr
 Ao5sWvrD5JRLkqZjR3TUs46e4GqbnLMMnot8UvfUPKqGNvtF+MQzggf+u/kChzey6os2ODLpDR1
 9D3bdIAbJGTBzIqjJplRkZ8Q=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b33d5272d189b10a;
	Fri, 23 Oct 2026 09:16:01 +0000
X-Mizu-Trace-ID: b33d5272d189b10a
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Flavio Leitner <fbl@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/5] ipv6: restrict mld_qrv to 255
Date: Fri, 23 Oct 2026 17:13:29 +0800
Message-ID: <20261023091419.167088-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023091419.167088-1-jiayuan.chen@linux.dev>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
into the u8 inet6_dev::mc_qrv, and every MLD retransmit counter derived
from it (mca_crcount, sf_crcount, mc_ifc_count, mc_dad_count) is u8 as
well. Anything above 255 silently wraps: 256 becomes 0, so no state
change report is ever retransmitted, and the first MLDv2 Query received
on the interface then trips the WARN_ON() in mld_update_qrv():

	WARN_ON(idev->mc_qrv == 0);

A plain bridge with mcast_querier enabled on the link is enough:

  WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
  Workqueue: mld mld_query_work
  RIP: 0010:mld_query_work+0x1fd2/0x2cb0
  Call Trace:
   <TASK>
   process_one_work+0x93a/0x1b20
   worker_thread+0x6d0/0x11d0
   kthread+0x358/0x470
   ret_from_fork+0x5b3/0x820
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Cap the sysctl at U8_MAX, the largest value mc_qrv can actually hold.

Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/sysctl_net_ipv6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 1a0a36dcdabc..05a384680332 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -29,6 +29,7 @@ static u32 rt6_multipath_hash_fields_all_mask =
 	FIB_MULTIPATH_HASH_FIELD_ALL_MASK;
 static u32 ioam6_id_max = IOAM6_DEFAULT_ID;
 static u64 ioam6_id_wide_max = IOAM6_DEFAULT_ID_WIDE;
+static int mld_qrv_max = U8_MAX;
 
 static int proc_rt6_multipath_hash_policy(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp, loff_t *ppos)
@@ -229,7 +230,8 @@ static struct ctl_table ipv6_rotable[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &mld_qrv_max,
 	},
 #ifdef CONFIG_NETLABEL
 	{
-- 
2.43.0

