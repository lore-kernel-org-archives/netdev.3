Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766445;
	b=P4ivC8Ui17GVKAVlivqxtiqVDhiYqMAWgxjuMF/61RUvw8gZKHe16e0W9GpVY2+NAqh3
	 L9dYfBoL2+V68FNTluf2Mc7UQTzfc0pw5g2vZ1cbHpj7cxTFSavpGsXIXrU3e091OQjHP
	 WQznmInmJ1XpYJaA7wbpHd6bSUzO30rC5iPNz9ufpUPGn+RDgLV0Meywha4GLHiD/LU6x
	 JWewiYSGWsP7EIZPIrb7IXpQBA7NE7OUbDHn9M7snU2sdrzpBhFL3zvP1xd6f+lfCJx3F
	 yBeQcKxUNuYBHyIOUl30BIIC+48DiHrVDQ3KQ+TJ9yeZpBm/ddqAPHndivd+g129gvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766445;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rQHeBum8IoN4wUsblO3htR9RGFV6GnquaIlN8uIvfcU=;
	b=f4fG2LmRfsJ9o7nXcJfG+weG8S4Fxv1U8YiZLmB2/X/P9qoeZ50BWiKbQrHwYLAsZhgY
	 qrxJ/So2ZLrhW9vGIcMT4BggO1I351V6Do/Id11LgDYioxgJX7V7SztqxYdRklaM36ZA0
	 DYn8d0J8qrDPEqziDxjW5PaoJIacBcU0IiY/ygLm7qaCEts1m90tPH9Hi+MoeqcGvXeAR
	 UtUr29mQiOEy5wvDLCNqHdRgPVNyHYGj+8Xq/KZkvOlwcsEqOnNml3qYoRVZI5BcIfTin
	 Q405sdVUyaEkBviyypi+86SWC4dKOdqpB3yGFdwhZ6WbGjOOMYqxvEuhGsry4DJ/gqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=etkh3MJ0;
	arc=none smtp.remote-ip=43.163.128.48
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCD606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DCD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=etkh3MJ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792766440; bh=rQHeBum8IoN4wUsblO3htR9RGFV6GnquaIlN8uIvfcU=;
	h=From:To:Cc:Subject:Date;
	b=etkh3MJ0ulISNEqx/5EHahVSTu6vENFqPUVWiUOBYLvbdK8BIHC3kxqZ0YjnBPxMJ
	 oDXmuq8TekjFX2tprrprjK0/P93d1WG3eXvJzmdr3vedATfsedQ37CS/6aogGgxeui
	 X++Fx4GxaO/HkoSn/VPsuCJOwlrDYkpUrfBXbBiE=
Received: from kernel-lab.tail5e91bb.ts.net ([39.144.194.158])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A2487023; Fri, 23 Oct 2026 22:40:36 +0800
X-QQ-mid: xmsmtpt1792766436t479bfrd7
Message-ID: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
X-QQ-XMAILINFO: Nnw8JvMpFyP7mjlvYHkB+MnWu/UQWl4GoX2OQ7W/kKANeSpnw+q/kadNSXEbLU
	 n5d7+Xj8NDB+nfACkz5+CuPuYM/ke+CNPMbp1LjKZd7O/tWXC/x3A6yUOMixoB9AEqEwE1yfH9T/
	 2sc3L655y/vMRjmvEDBeeacjyN23wLm25sfQzaTu5yrS9DwwMfi1NgtZvJuJlb2eZEwdlV4DBh9h
	 78RL56t9+ptuldPDCWaBRj9EYqVPdJi1GYgsHXeBWYibPrKYHYcu4pY5B91i1meEG3xMkNn6sTAC
	 0TnqvY5oSdO49c58FbHjEyZ4RmcSX0t+wvSzVOcrItxG396sTzAXZV0U+4IZe25qZOBlDWWYIPy4
	 HJ6b/E+VMm4uxRi+UhSNleLBUMj209AUQ7sq7bVZADCnXFlXFjygB1B7pn32wvupR/Qd6bnhM/pv
	 JmqhiUGsSvUqzxpRi/BXPpR97Hcd2PNJ5v/UGzz2PW2gd/3LPGoAsADFPLvPdAtUBjQ6Utg8Bh9I
	 xrh5DFrcPWOS1m/+IaJihkbJXyc+d7sy7EfsxgX50eIOIVxjkNJsHqzdH4AGkX2jq+EFrRU4rF1t
	 /RHTGoNPeefrD7Ux8BfL/RavAX2x0zfXNKG0yqyx8jMUuFD+uI/HMx4kTzBeY8/UK1xdDTYP2nCt
	 wNer4Jc4IGYtSioSKracLZDppVGDHYdZHP2/vuW9wNyle/XSG34oOVCf8PZX7Z+4IpJWCEXE66F/
	 rZE588ZAE7zCGbO2Nua1wd40tgW9D6YZSsdAV+C4KnKmALIJmZlhAjdpjfzpFOiXTZBvNWMpfsFy
	 1A10o7Mm8u/gNxaTqVcAM9IK9Lcf9RK1I++1rvb/wXvd0HLQvlsnulEKxx25ZtEfDxusndiYeZK3
	 ZF/9z3HzHs07AzGKU/Gt/GEHlQzJaAF1D4xde7W+jG6aBBO7ifypRbzt/6YOHsCoskVU8ZdlbhTo
	 UkWteVlcgtbvp8LMUeYbTPRyeEyDwhaTLB4t3p+pnk0exA+KH+RQdON+qiB2Ykcu/AxWcnN7noqH
	 /jpnWzQBW13bSlJFh7wwdXcj2B2T09vMaPUYitoKKSGgpoB9mo4Mu6SMqiRx087CEWW9S7cB4j3B
	 dWNcJdiai3mMBXZrTNLLoXizQOiHbJRUwtPMpvpTwrKYu4ZiTpOcXyLs6lB2Jp0Poqk/H9q+ZU/q
	 PvxXc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yingjie Wang <1075151112@qq.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiayuan.chen@linux.dev,
	ncardwell@google.com,
	kuniyu@google.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
Date: Fri, 23 Oct 2026 22:40:36 +0800
X-OQ-MSGID: <20261023144036.152675-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
an upper bound, so it accepts values through 255. Values above 31 make
the shift undefined.

A process with CAP_NET_ADMIN in the target network namespace can set the
per-netns sysctl. With CONFIG_UBSAN_SHIFT=y, setting it to 32 and sending
TCP data over loopback triggers:

  UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  Call Trace:
   __ubsan_handle_shift_out_of_bounds
   tcp_tso_segs
   tcp_write_xmit
   __tcp_push_pending_frames
   tcp_push
   tcp_sendmsg_locked

Limit the sysctl to 31, the largest valid shift count for a u32, and
document the accepted range. Writes of larger values now fail with
-EINVAL.

On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
accepted, values 32 and 255 returned -EINVAL, and TCP traffic with the
valid boundary values produced no sanitizer diagnostics.

Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
v2:
- Attach the upper bound to tcp_tso_rtt_log instead of ip_dynaddr, as
  pointed out by Jiayuan Chen and Neal Cardwell.
- Re-run checkpatch and boundary tests on the corrected patch.
- Do not carry Eric Dumazet's Reviewed-by tag because the code changed.

v1: https://lore.kernel.org/netdev/tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com/

 Documentation/networking/ip-sysctl.rst | 2 ++
 net/ipv4/sysctl_net_ipv4.c             | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 8edd2eb2a..66a54c510 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1128,6 +1128,8 @@ tcp_tso_rtt_log - INTEGER
 
 	If you want to use the old autosizing, set this sysctl to 0.
 
+	Possible values are [0, 31], inclusive.
+
 	Default: 9  (2^9 = 512 usec)
 
 tcp_pacing_ss_ratio - INTEGER
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa3..bf193e7ec 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -26,6 +26,7 @@ static int ip_local_port_range_max[] = { 65535, 65535 };
 static int tcp_adv_win_scale_min = -31;
 static int tcp_adv_win_scale_max = 31;
 static int tcp_app_win_max = 31;
+static int tcp_tso_rtt_log_max = 31;
 static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
 static int tcp_min_snd_mss_max = 65535;
 static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
@@ -1406,6 +1407,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.extra2		= &tcp_tso_rtt_log_max,
 	},
 	{
 		.procname	= "tcp_min_rtt_wlen",

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.43.0

