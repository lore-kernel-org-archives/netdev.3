Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3B4A2A4F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306654; cv=none; b=Pw+h7J6NsfwNaNT+aetQBgmMSlheT8ZW9dAEo6d3of4VXRLpIqfK8KjJ+xzHT5aHIEKHeX/sYmBc+MFWIFhXyu5CLgg5o6uAhL1zLSoM2tvjhgvK7esAgZgT2sTXBF7THwsQvMa8VV8CH69L/6XYZ1u/LThU8QhKCFpdzdusCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306654; c=relaxed/simple;
	bh=YQ50butHh0in7r+TRzz+4pIBFjn39KwhiYH1RxMiXWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2URQGYAwqVyrI8VH2eEy/6WmnwDVZPMv/g9XZjwAZcs7SmKMLiHTFa+JdqsG46TNvd5GzAaN0WF0s/KzmvKy8s8VOeV/KzKjg8AiUcfzVCo1Pprx7NKRaFsDs/UR9+a9fkNaSmJoGAWlMe05zg8RZ98pIkLewhzw8WAVgKuDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=BGpYXTR2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="BGpYXTR2"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a20e9efeso11928506d6.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306652; x=1791911452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjIQJmVhnnc4JEVUqtlMdFZejCmrpUXoYlA59SZs6m0=;
        b=BGpYXTR27YmweNzRa5UYtYL14gBi5OkIwhltpf/uO4+y/rJzXUqt9ZMiu4zzmQTdlX
         ZDVwq9pFvPm4ec6MAzMiRKbO6Pf2KLIsNz5tpvSR3iIkbd5oFeLfEHE2+qa11539n0OY
         1KEkKhbvGHz48E4Y/UV/0fbLb0salwAofbyQBy0aNzIhG2R81X+0Vms2mIYHbZYDUlA4
         4L582FQg5PMpWSKbhkymHGZdvJLig4Dn6HKnB9xmMWgL4V3pWP31OH9y+MThEr6ZlxVI
         VFIYqm0knVYa5z0BE22FsU3gdVVfv3VrR9g2q3bzH/565NthWnaOH1R/WKhTf4T/F4jZ
         oQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306652; x=1791911452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjIQJmVhnnc4JEVUqtlMdFZejCmrpUXoYlA59SZs6m0=;
        b=smgPW7kwpqN/MCA77gp5OMSHj/AkdUdz578KXgURYZ9LJBfQwC4Mc2MG5FWD/6Vdzh
         z5QxEvlHWVIvQoN92/Zmj620pAyEmc/iYVGbnqyJTeaiB1UNdn5AqotIaB/SDZbiiQFl
         TgO3HuXurreKOWpKWFfgw9fWHWlQOdAI4BdyuC6CI85+SiOLY13ov9jdXADA1l15BLuT
         wx1aHDPvMqKVmXW3TAtFd5jWaDgWU3LeJh2Otk8EElaROoGA3rIwEwDA9kMdml24+EaE
         RRnYT8+siltdpSHrW0N/D36+dZSskD7DSSnqPwmM4YO9yMtjE21zK0ytGnbjMGxXesBO
         4c9A==
X-Gm-Message-State: AFuF++mv93Wx1AsoNIKo9z1VG3YUfCrh3+Gss4LpklrSp6z1nHwxrZ6A
	tRsqJUbgQWkZiK90CyD7T7kyqoYCBcRfGMOBiG9vfct9WTnCgulKFwFj82VDXaFUOOo=
X-Gm-Gg: AYBFou2sgQ9Ni0DZvqz3+iareZWN9JF6/cPMIUjggla4i83CXGkYynzuKTWvw+A3Re2
	8QLqiVhxh5NWIj/mqCgvKBFCi0P+HBYIERFadSyi/YsNe1roHojQRRo5/rmVbwXnw9IPyCLGa+P
	CWNgfrJCqsx9tSA6b/AZY8D0ZHHqM/DfC9NoHKUGtRrMFA+u7rd4h6fl0zfm4dE+GDyulllPw1c
	TUzMmGznruPPgF/+F+bZ/8MREfD6IIINOFmUR78VFvutbORhWtbloGQY+ztXjpm3xwaeFoEFaYt
	Fi70CSgMmM8wK1O7ZcF8+GI2i/icpuab56pSSbzRhKnOysG/wdsEwQJ568v+g34Z0/7L3dNaFvd
	kB44yuZDkYru7fxPfNyigMCWzFo0TRoP43UHso4LNdi8thytYLk+f4ymcDmpgrGHxZgL+dWSb+m
	32Wh5LFj1RpVl+v734wu28EClBAgEKS/oe3/n95uEA/b3dD8QV4xRL7mguXVBgMNcdAQ4tZ+d1u
	zzvi0ntqTdoI/U=
X-Received: by 2002:a05:620a:2947:b0:93b:d7a0:d9e3 with SMTP id af79cd13be357-93e8f53852cmr405007885a.61.1791306651621;
        Tue, 06 Oct 2026 10:10:51 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b690f3sm117037806d6.24.2026.10.06.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:22 +0000
Subject: [PATCH net-next 7/9] net: skbuff: don't BUG() on leftover length
 in skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-7-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=1558;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=YQ50butHh0in7r+TRzz+4pIBFjn39KwhiYH1RxMiXWY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ9gfSvJiWs9uWxS8HbhLveAUX65vUd2iG8R0qZJ2bMPItlfPjuGBWyF44xyBKoelu4XtnTNXUJ
 VzXnDkBVCygs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_bits() has the same check as skb_checksum(): it BUG()s
if it runs out of skb before it runs out of @len.  This one gets hit:
commit 7d63b6712538 ("icmp: guard against too small mtu") and commit
f99cd56230f5 ("net: Remove acked SYN flag from packet in the transmit
queue correctly") each fixed a crash here from icmp_glue_bits().

It can't just return, though.  Its callers copy into a buffer that is
about to go out on the wire, an ICMP error quoting the offending packet
for example, so bailing out early would send whatever was left in the
rest of that buffer.

Warn once, zero the part of the buffer we didn't fill and return 0.  As
with skb_checksum(), the checksum is wrong and the packet gets dropped
by whoever receives it.  @len is an int, so only zero when it is
positive; a negative @len from a broken caller must not turn into a
huge memset().

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c8c2c0319b87..e29eda2eaf3f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3709,7 +3709,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (WARN_ON_ONCE(len)) {
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
+		return 0;
+	}
 	return csum;
 }
 EXPORT_SYMBOL(skb_copy_and_csum_bits);

-- 
2.55.0

