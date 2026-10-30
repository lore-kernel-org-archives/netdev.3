Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334152;
	b=CRkOnc3QfeQL99qwZ1Fm/QI5uRPzagHJjzdIqIQ5Me2ZYzUIX7we/wOuSPw/9qteZMxq
	 08IUzNaJCo6lOu9fZ5LJyJUEnOa6BsxxPG8yhsNq/gbk+8jMgpqgq936q1+dGtwaEBukB
	 lkeRhVZqafI5F4srlOFzI8Dv7ze2SwI2gQdEV0N0E5TlIkRh7j6kDC+Sa6rZD6MJDFIgZ
	 87wT4lSPOfepVgN6EyxBJepGRGtENJ5Gu/TNjw9j7SGfzpPE0/tqBok1Ud0QIyv5HGg/f
	 UsaiaCGcHxGuit8By2rWtvHmQmBK9ZFLM2ouplqP0D1FAiTpiUOEajWibpjzFHVqMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UIEkXZc77VKDSaNSSEztds7G46tOfShqTeBK0tv5jNo=;
	b=TaNCX/fuMQdMMi5ugvc6GCsx1gPSPlRxzu75/9U6iU+Spj1fEI/HzyOIx3jjwKSBq0oW
	 8zCoUPgzbPcwTp0QxUh0MyXMXz9Lz39NPitMZpWfQA7yzEMwbVoB3SqrF3b93QdkNbT/4
	 n8J8rKhiJadB/CCLNphcLCiKWUx3dV+OcO6jhLUZq0B5zthXf5ji2g3Y4GK4ybDOQwEzl
	 P7oII52Ogup8EAizsknNu7Z1WgYnt+knZ4kEVaY3U2nQDwQ7GVxpyfjE9mpSo32fdHtKR
	 TFHbDxFpidupF2ovD4KHSLAEaonavnddSx6mLbhQ/8xG33DBROm1aLG3PCRSkPySHfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Eg1lDcJl;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBD606A32D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DBD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Eg1lDcJl
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8439fe796ebso265431a34.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334151; x=1793938951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIEkXZc77VKDSaNSSEztds7G46tOfShqTeBK0tv5jNo=;
        b=Eg1lDcJlw04NV3IH/2Tl3IMynXUL1pmXUgDAtba7icKcUjOSnAsniK+cEQpWm6iZrw
         C0WcQkcKN2RGuCvTXhgNDciVIKg52lM0bDGRwZtuBXRgujm0MfRilzW71qln5am6AnGd
         JtPjIG8I0imy4vxFGyBMFoIKd4mRvK6wExzy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334151; x=1793938951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIEkXZc77VKDSaNSSEztds7G46tOfShqTeBK0tv5jNo=;
        b=S2OEaWyJQjLqidHUgTXmtcQMg1JljqeWd3NgGTnvnn1eZVzydbWnQENT5dvOdBbJt7
         JPylTeUJqEBCV53G9cfgAo4foTii+43WGAenp7tzTTvjirul+Rm46Cy6ARoFAKuBJrI4
         NaWXLGPykJYD9DCpq/6c/LuzhJYDBJjp+LMv7FfCCGLMf0s2NfWRjhg7bxM99VbT3dFH
         ArfaKhPKlZmE+cvZDzLeF0S3xn+DoWAYcljOdJFyQEtfNgNuCaKrPxfhIczhAEIo0X7g
         TR879tzI0wNnaYGvCrwgGCS6Mw9tp3Y7dxbrXevEpy/3DupaBTW8bnNmnEDuXc/HulOt
         tF8A==
X-Gm-Message-State: AFq9FYKW4gGhzLH3gQ7QRjScCA8aWaIbXV2QXEsxh3DXJubjEcsleam+
	1GtrmQPspWsYxHcwgQIKr2yti50gEjdHWrZdhQSfTQXn9KyckBnwXXepU2iULT2MbPkr0WfyPGc
	J6aRD9w4=
X-Gm-Gg: AYBFou3HX4tVkjql+1WLK9h05EEvpUwbFvc5zQmO1NCo/m4fa6jdata9DLDmLzztDZS
	8sWVB3ihSMjr4ur3a28VEUeIV+U4L6zqNh4lGLZNoLiObYH29cKD76oJhHel3vHUKwuMDNhNoVS
	YxTCIGYAH0DEuE0OAx4yaLPXaBgJX3mJ00tMoYlmSEc0UvPJFGB35DnEp3NytFZv4ItOiCQyp1A
	Xokgjg9gkhMCPAgYwmBZHj6Y+ENks4vZSNW7bNXAxH93RnlcblSgHve4XSkn2XtRjCWo1CNJqjI
	Vm7zwr5HH63G4XJX++UDl/1CL2BPwefd1QLpgwvP4XHib8kFiZwQp3JQXPexr1+7L/WjnjTTy3F
	vyso80efogoeS9CaYBPmj9WTZ9IWDPZA6RePF7bEay0KMOKka5ovXGnXvxHPAyUIFCEB+lgYCAe
	qqrEi36UlcYWYraZx3KzEZ9mWeIqFnGL2ovzcrunVu0r+Dv6R62RywtUnKopPqmj52BXWESv3d+
	ypOWIAhmzeFvhDG+pLZVsP8GCv+k91PbcK8tCavz+Vs2Z1cFSXrqSxM4TnbvpgF5FHXoNC2kocP
	+rouy6sP1GOmb/xc4tzCdgXdKWSy55XQlcp9BAENq4nwaWFk1JjRY/3qSHeHVzOxsqJAKj/kN6a
	vK6Zs6kc8aQh9tdeQTVS8CmyOViDgsw==
X-Received: by 2002:a05:6830:2e10:b0:822:978:f7bd with SMTP id 46e09a7af769-85d36639c20mr971906a34.28.1793334151292;
        Thu, 29 Oct 2026 21:22:31 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm1160788a34.2.2026.10.29.21.22.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:31 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] ipv4: keep XFRM headers out of corked skb lengths
Date: Thu, 29 Oct 2026 21:22:29 -0700
Message-ID: <20261030042229.74068-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

__ip_append_data() allocates space for dst.header_len in the first skb,
but includes that space in skb->len until __ip_make_skb() pulls it.
Fragment accounting uses an MTU that already excludes the XFRM headers.
As a result, the next skb can have a fraggap larger than its capped
datalen, and skb_copy_and_csum_bits() can overwrite its shared info.

For example, five AH tunnel states can reserve 500 bytes while leaving
an effective MTU of 348. With 40 bytes of IPv4 options, the second skb
has room for 288 bytes of fragment data but receives a 500-byte gap
copy. The overwritten shared info is subsequently consumed by the skb
release paths.

Reserve the XFRM headers together with the link-layer headroom instead.
This keeps skb->len, the gap-copy offsets and the trim lengths relative
to the IPv4 packet throughout corking. The network and transport header
addresses and the headroom available to XFRM at output are unchanged.
Both paged and linear allocations, including subsequent corked appends,
use the corrected accounting.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/ipv4/ip_output.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 3396f177a18d..d42d776af273 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1150,16 +1150,16 @@ static int __ip_append_data(struct sock *sk,
 			 */
 			skb->ip_summed = csummode;
 			skb->csum = 0;
-			skb_reserve(skb, hh_len);
+			skb_reserve(skb, hh_len + exthdrlen);
 
 			/*
 			 *	Find where to start putting bytes.
 			 */
-			data = skb_put(skb, fraglen + exthdrlen - pagedlen);
-			skb_set_network_header(skb, exthdrlen);
+			data = skb_put(skb, fraglen - pagedlen);
+			skb_reset_network_header(skb);
 			skb->transport_header = (skb->network_header +
 						 fragheaderlen);
-			data += fragheaderlen + exthdrlen;
+			data += fragheaderlen;
 
 			if (fraggap) {
 				skb->csum = skb_copy_and_csum_bits(

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
