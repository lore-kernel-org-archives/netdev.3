Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728D356750
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787429503; cv=none; b=cb/eTqp4jCCCubWifHn2WUJBpI0jf7vilWE16K1f6vGFaIfEtgOzwQsRJjDMdlrsAvBlKnRtLF+AT1NSqtDPA8gL3wK/aT5JiIoWJATrvK5OUrTgVpwLkfvvMFPtJaAiSnfZ8K5/VDmu7rtY3zq2ldX4VfdLPcAeFgqpY84wW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787429503; c=relaxed/simple;
	bh=gY8pFX7eDDeZz3RXVa7ARwOLkXBhrB1p6G3Gx3Zy2o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMjF7CJUgaNDwWAWYUd7O1964UeZn9NiSB+Fs4wXtjBjKyFtfPo7XOuL2tqUEOLWr+mGKMVZ/dRXrhsqDWbtzuEYYSSmwBUYx3dUnIaKvTo7QkuFeRo3wsoSN0LaHz5GbB2E35/1bv1eQhMk23Wqo7rDVVgu+BgFgt+PmaYf6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=HzRj1If/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HzRj1If/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c26d7e951so316361366b.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1787429500; x=1788034300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVtGEBOLfPUf9fsvzZfuQ+GouRuuY6QxJu3hiEIATS4=;
        b=HzRj1If/WA4D0QKLfuosG/1pRewvCW0rfDBmX5T/egvaxIoKoHY2ZsEzb3eSxSm8co
         O+4gyETdxElV1c6uDJM0tvQlSue6yYzKWYH2pDHu7co50Y0Wa7OwJDEXfyYvICaCy3ym
         gPJ6ZyPQXEoFRsDtPVr0+YqMCHnuXqPtVq6XKmTzsLM+RsuZHmHxTf1BaCNuDEGcDklF
         Aj/IhNrl10XkhCfldI2C7k13A16I23xT4GmqDnV1b2ntr0tsR4LNnF2ZRhkOuGP0Gubj
         i81LAxCS1O4wGmH2AH+b9C7Ucv/lq7yCt2TxE+yY9WoDQ2DgFDPqOEAM/ol7y+aayxk3
         LIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787429500; x=1788034300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVtGEBOLfPUf9fsvzZfuQ+GouRuuY6QxJu3hiEIATS4=;
        b=I1swEkjVcgTldutVFlU6WkZwoMHBOmdZPlm7E394chVGRVoHUjg0iIzGFT5GIAVIuP
         lqcGh3dsxyvIwsPTEuBJ2UFbAQE92LeQ+4StNNrMUqISTPUZMmVUwy31yuMP6YIB9Qqy
         ZYA5yZqWOS16V2xQke6cf9fCpr196FsWau5P/qa+oF6Z4U7oWSIAf/13j02uvO4+nGDs
         cRGWyGdpcfyPJM8f94Toq6NoRHTLB11U/fHPqpTI2GJfdGkrBuU94pQoRrNAnYBYXkGK
         TtmNQONTqDdnX1mkmof3d2Rc6WJU18WEd1j/29r5XbArRjGRebNa+jSe/PXuNsDZ7q5P
         8bRA==
X-Gm-Message-State: AFuF++mydgUk9GMkNclHQyLPKZull69+ev9yymumFsAP7OyLoT8SlL0+
	bsKv8lVW2BEy9vePsUxwnrtpjVm7ghlZJtXABCjMaSaV301WUkMpdfbXryjFnnHm0uFJZDTYgU/
	0Gb/B6j3hRw==
X-Gm-Gg: AR+sD117u2LmV2zfoBCahk9+PF2QvA/m95k9/fESXMWZ3Dj1h+2amKkp6aV1yCHDXFp
	bStAtlNnncHziSYA0XgtYHz/82Y/iIJlZGzrFHaBFfO+VGIK8/lpTGZ+PFjc/ncsDV1yaioumOv
	88zlI5r/vYjbrwnWLkC7Wg4pX+fkku0gAw/5cP7WBuOVIlLQXpD18Guz2HZb7vgDPSH2/Prfqd5
	PXMTGOg30HK0+e0fddejqbvfnTLDIg1z9GJHfGEQw8gC39ZCNtccjGS8Z6y9gPDkfgQ4ZRQQeuD
	JPR7DgedBSKmEWlhyOmDZM9QQBOiy5eG+ERs3NxldWUNif5Gw6Qe23tJ9EkYcIUMk4nFjJjN/yq
	L9ZrJKjbB2PHzqj1Erl8SbaWdYHVYVXjvVPA1Op769Kl9lXVdDUAMkXxEalOgSefoc1cSZiYPxq
	ItDsz2042c4ajs5RUvy6E7Zp3mXndF56wkymX8EGp+Z6WKAiRmvpeeNi7hl8h78INrVOcGX5tn5
	DtuPplOBRzsm6r1ucxYjGVZxP+0wa8FxeDz+BJUrCBSzi4cXgu4uEYUtJwbCA==
X-Received: by 2002:a17:907:3f88:b0:c24:8e4b:2baa with SMTP id a640c23a62f3a-c248e4b347fmr961860666b.15.1787429500178;
        Sat, 22 Aug 2026 13:11:40 -0700 (PDT)
Received: from localhost.localdomain (chello089173060039.chello.sk. [89.173.60.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f99basm444347766b.37.2026.08.22.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 13:11:39 -0700 (PDT)
From: Rastislav Szabo <rastislav.szabo@isovalent.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	dima@arista.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 1/2] net/tcp: fix TCP-AO key deletion in VRFs
Date: Sat, 22 Aug 2026 22:11:18 +0200
Message-ID: <20260822201119.272269-1-rastislav.szabo@isovalent.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP-AO keys with TCP_AO_KEYF_IFINDEX store the VRF L3 interface index in
l3index. tcp_ao_del_cmd() validates the supplied ifindex, but does not
assign it to its local l3index before matching keys.

As a result, deleting a key scoped to a non-default VRF always fails with
ENOENT because it is matched against l3index 0.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Cc: stable@vger.kernel.org
Signed-off-by: Rastislav Szabo <rastislav.szabo@isovalent.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Changes in v2:
- Add review tags.

 net/ipv4/tcp_ao.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 5094267447ae..26864621e6de 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1834,6 +1834,9 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	if (cmd.ifindex && !(cmd.keyflags & TCP_AO_KEYF_IFINDEX))
 		return -EINVAL;
 
+	if (cmd.keyflags & TCP_AO_KEYF_IFINDEX)
+		l3index = cmd.ifindex;
+
 	ao_info = setsockopt_ao_info(sk);
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);

base-commit: 746fc0787f616da418ffc04a110296fe95d53491
-- 
2.43.0
