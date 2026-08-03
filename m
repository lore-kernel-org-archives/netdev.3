Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7E8634C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719891; cv=none; b=X1NRl/RPo9S3LWDCOBK3O9leVm6ntmFyi5joiUoJLRNf+URXviJRCkETOSl6VjBwmFPBJEDtu7C3fRd4YCq5sg0j1DHJnof6pHdxo+q4pGQToN1A4FvixX19idtPRPnQV6cQIgv5HRtdCZFRuqNiKU2yuwI3eQ9ZMfDk/vuMmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719891; c=relaxed/simple;
	bh=CH2yPRvu7YdIUvb5xE1pfDe3mbwUquBCkl5cmjeONsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5UQWW/ykvNiDzMiI8M7BdFEefxH0nDBkna1HHDdHUphLbixqbgZf1Zj/ou0FlFt7YmFHSQJSc3seDwTM4xwMxHak/4F2ftAPVx03N6Mvdqt9Sf1BDSlBuEt3Nhll+3cUm/TPTIF5oT8uPlOvg1DuwwAO9bd3jY28bZfk0Ijg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=K1gMHckQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="K1gMHckQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e347638adso3295766a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785719890; x=1786324690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tN1AhzaCERTFN6UDp5A+RMuVWhHwcSrtAn50QqE/2+g=;
        b=K1gMHckQyU6KJ7eI45JNgWID4uH0E92JZen1FYEFjaxC9V9CPE/AH/Gya3CTcTBVBX
         HqeQ5neaxR1LVUQrmIls38iOfe6qCbmC+1/UeZhnkx8rx+ivksR1MDrdTm3BBDRqrRQo
         IVjq72V52mdD/Y2RC/JIi16JrtPDzSmLuEdWAJG5WRA4zVP4mo52GaMJXTqAuM5HUqp7
         B+IFz2rsmJa42XRCfS41Nceug5uTQh2d83Yhkznk8gz3aH9VcmTrwcoe1qGWWqZ9T5AY
         MF/RAVZLo/4iLmTvmORiTeBDgyL6xPHZifDhFiDWIY6HKCHGJPRO/DRuVVmEyqOj+Fww
         dY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785719890; x=1786324690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tN1AhzaCERTFN6UDp5A+RMuVWhHwcSrtAn50QqE/2+g=;
        b=TGQKaX+262t/rs5GC2Qy+PMvGIfzHhmHb63pOM1sZ5twkB8IV+rOzyku3Xc81T/FaF
         fN9RXnJkkO7ImmuBRP61E+XLO4c27cgvEE+NrCvMeZIPIOX6InUhgGPD9FOFlAh3vtFU
         HBHGY5c7j0/AiAusw6MhXRqVnj7/oIf2Avh4RhhGaoF4kKnVlC45bWejw5uPetvq+zkT
         MOCxHGjTAmQhKkhfqJSrUh4AlV7R0MxAa31qnATdibFNPBQqmgjRnN1gSu7F1dVBW/4u
         4zqrlEt1davreEuzl2UOU1tkdXdcJOLXe7Z6Y+VTWtIqy8HCRBxKlEBXFhIUO01LWbv7
         Va/g==
X-Gm-Message-State: AOJu0Yyf09MhesF1ZejWTnS7xf2KUVr9OQ+p+a02s6KtEglOx4jS43ZR
	B4WFoRyT/hbb1YD4ElkVcgPhuqo087sy1Kk2CIqBsNPUgS20eVP5ee5ZLEOzJJaiJHHGFr2K0IR
	zbrn7FANCxX83Kg==
X-Gm-Gg: AR+sD10elimhnONBrlgVW6jS55+Fx4fZak5jzxN8hBxdC3LNIyPzUvVfgAgA6XfK+4l
	w6DrP5zXeGQCUZ4foWIcnUsJFmcRBy9xIYgmHXl3D3DX5pC4fT/NzFSl+INawhbuc/1SA14g+a3
	CmkGQOv0mrtFEkRcPJci5pL1k3rXbwS0ghSGkWwXtJdcgoYClvVtUzeF6UqepVUNIHuog46nOf5
	6PXQ5sWmGA+kmWw6jnZMicZJCLZZbjLVqTnJXQEmqEJ1ESqLZVoqBb7vIKrdILTXqL6zR72JdrO
	MES2wYLoats0uF0clq9l5WED+RT7JxxlqnN7UKj1LfnubrE7+ZGd4S0MZdA+eo7Ny++b1iUB7Yj
	CVASpcGJgmdSwEa6kO5gITo477Z0RtgswInquJhj5X3FcjzmP+M2GrB73OWVJmg/Mf/Oa0BOgqZ
	/KyOD0cTtQLrsVDEr0DlojTmQgzLcoxfv1gtAD93Gcca5KElLNnT2qZz662zuFjhBjB2EJz3obF
	OdzTt33xGD8sQ==
X-Received: by 2002:a17:90b:51c2:b0:38e:79f:76ad with SMTP id 98e67ed59e1d1-38fbc4ff4c1mr7142205a91.23.1785719889487;
        Sun, 02 Aug 2026 18:18:09 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30e381esm3072186a91.15.2026.08.02.18.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:18:08 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Date: Mon,  3 Aug 2026 09:17:55 +0800
Message-ID: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_cache_report() builds short IGMP reports for mrouted from a packet
that may be a synthetic RTM_GETROUTE query. That query skb stores the
netlink requester portid in NETLINK_CB(), but the report is delivered to
a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().

Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
original packet and then copying the entire 48-byte skb control block to
the report skb. For synthetic route-query packets, this copies
NETLINK_CB() bytes into IPCB() and lets a controlled portid corrupt
IPCB(skb)->opt. With IP_RECVOPTS or IP_RETOPTS enabled, the raw socket
receive path can then copy past the short report packet or overflow the
stack option buffer.

Keep the IP_PKTINFO support, but copy only the pktinfo fields prepared
by ipv4_pktinfo_prepare().

This changes the accidental IP_RECVOPTS/IP_RETOPTS behavior for these
short cache reports, but that behavior was only a side effect of
copying the entire control block and was never intended to work.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- go back to the v1 scope and stop changing the common path
- remove memset(), since alloc_skb() already clears the control block
- v2 Link: https://lore.kernel.org/all/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai/
changes in v2:
- reword the commit message to say the entire 48-byte skb control block is copied
- mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was never intended
- move the pktinfo copy to the common path so both report branches are covered
- v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..56dfa43406c2d 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1058,6 +1058,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
 	const int ihl = ip_hdrlen(pkt);
+	struct in_pktinfo *info;
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
@@ -1113,7 +1114,9 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
 		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
+		info = PKTINFO_SKB_CB(skb);
+		info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
+		info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
-- 
2.43.0
