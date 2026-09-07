Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BB427F91
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767934; cv=none; b=VLsAUbEUASe6tnaVutmJoaTp+dk2kVhV3lhGet+7cDfdCmPnaWLcuitajzTC/dxRvcsiW7lB8XcIujLkiEWfxkTyKWFEYWnu++Pjiy3Thb79N5HG/6IVPdaZXVp2+j2o6dYKDXN9rwUjPumRhZyE4DFqXazsUol5F67Ty67VnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767934; c=relaxed/simple;
	bh=766tLnydMOZdpH9/E8tnR9AYugZQEf+BKBeXLjyldEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IzPQpSx6ph0rJEZliF+aMYKq+J73o2ZJ6kyz1bLjNUHhx7bsDUiCdcmVhxIeDDVm0fywk/eJLJcIvkromPmbo7SU83Cdt3zx7MFUQYW7TRQnd5/q35bzDcJDVu7DYfOY7aiZw8spMEZ0KWFD4sY/2EORuDeO+wU46BEGq9ZM0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNQMfJER; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNQMfJER"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90cc0ed09b5so31121266d6.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767931; x=1789372731; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3MmM5X8B8Zwm6S8BewYUtvvv5At7631+EBIqGdqMXc=;
        b=vNQMfJER2KLVfMVlPmzPuRLePqWrebsUR3N6JesSdlEW15GLES4HQ6ikNqj/L2m2NZ
         hwTUvDpLOtsZJ2pjd1AILbhBE9/hYzNlLLwPfiPmMo/K4QZVlp1ydNslkDD2IzMKRXL7
         evcGgTtAuPOPmEFe089Bwq9PBkMAPVhmjI0IA5rMVADz8xmrVSlD3Uuyuh0B8GhR4EXp
         Xvh7/7nqhHDXzqa30R8y6ZukIAdJkxRG6g6gcgWVZHrZPgfwWVueJRh3gHR/03zoU3XS
         r7oG62VDf3fe6QGPzqnYu0Er/3lLTIss6JISUTRtYFUDjGWucWfm9ytERZxtwAUHAY6Q
         Meng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767931; x=1789372731;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3MmM5X8B8Zwm6S8BewYUtvvv5At7631+EBIqGdqMXc=;
        b=LQi6oZAVSo7vXsMGTDRHW71e4CIJw0msT3wq2TlEmlmgorH+5yEedludEaZxbcVG1w
         ldmc1sFna+kRi9VdwqVmIU/C3NJtBtbklIfWXNhSXBqb2oINJ5E5pd7VgPgwCqKKyhWR
         EH1+FH5lJV8mVl48j7iOBVtLr9HS4dxbO2OctwxH+bpWjjSglaMofL/nBfX86hQKe689
         tG3icQLSGN6yzwUBwXVDUxpfnXfg1lI5tjPzMbUxDBDVOQ9YBT6uGg0RgEjS5tVoLv5q
         04vzTN+wsUhPl1Y4atOjWP6pxU6fokWBjTlUPTc9RuwPa3v46Qe+ut1XH9ceTv26MHZo
         PAaw==
X-Forwarded-Encrypted: i=1; AKwUvBwVAs663Lq9eHMZcEodaIhrDo/f+3zZHMN96PMM4rjfSDzGjfmRbzMDIeh016WB77iHKel8QnY=@vger.kernel.org
X-Gm-Message-State: AFuF++kj+aHDwujuUHZ4dY2hrIZ5q/UZDnHSlHXHlSFErA6OlO1lDze/
	f11JozuUy4dxcPQrcGizIt7jWzFFedcjU6g4KLsSD5AObDbq8AWagCCPsmgLnVKjP4d6YlS9bqS
	GPTSZWknxyi4s3Q==
X-Received: from qvil12.prod.google.com ([2002:a0c:d6cc:0:b0:910:45cc:dc80])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2266:b0:90e:995c:42d2 with SMTP id 6a1803df08f44-9103ef94182mr258203786d6.12.1788767930961;
 Mon, 07 Sep 2026 00:58:50 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:39 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-3-edumazet@google.com>
Subject: [PATCH net-next 2/9] sit: charge ip_tunnel_prl_entry allocations to memcg
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipip6_tunnel_add_prl() allocates struct ip_tunnel_prl_entry for each
potential router entry added via SIOCADDPRL.
An unprivileged user with CAP_NET_ADMIN in a user namespace can add
an unbounded number of entries, consuming uncharged kernel memory.

Commit 1b51d8271973 ("memcg: ipv6/sit: account and don't WARN on
ip_tunnel_prl structs allocation") added accounting to the temporary
buffer in ipip6_tunnel_get_prl(), but missed the entry allocations
in ipip6_tunnel_add_prl().

Use GFP_KERNEL_ACCOUNT when allocating struct ip_tunnel_prl_entry.

Fixes: 1b51d8271973 ("memcg: ipv6/sit: account and don't WARN on ip_tunnel_prl structs allocation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 4438b2472b28764f813b9162bdb9f6b6dee5a007..9a2bbd76d3794849cd11c6530ba1303bf53fa388 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -395,7 +395,7 @@ ipip6_tunnel_add_prl(struct ip_tunnel *t, struct ip_tunnel_prl *a, int chg)
 		goto out;
 	}
 
-	p = kzalloc_obj(struct ip_tunnel_prl_entry);
+	p = kzalloc_obj(struct ip_tunnel_prl_entry, GFP_KERNEL_ACCOUNT);
 	if (!p) {
 		err = -ENOBUFS;
 		goto out;
-- 
2.55.0.979.g7e5102b832-goog

