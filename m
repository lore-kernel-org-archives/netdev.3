Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266638;
	b=AZJazO0W8OYTTYZJxV4n9TIJR/nxu5bYmje7csc9b460K3t8CP1/YCVvm3lKFRdzyLhi
	 rGJq2JRjvrAsgC5g718I3HD3n8dqegrPpPnWj6FRJzc9+iySNv/CT8iYhBeoiQDQzQH4L
	 G3oSQjcLk4+pCcU3dlpZ2Q8IozR51gqcKgDW/Et3ynfxCyB6XNU/3dqZJQ0e8zM3G6JQ/
	 XB8OMSmM73SPyAiXhlIfUqy/Ci7XlE3TmpUugugEHCgp5nKtQlIT6cZoyJQJ5TuiW29++
	 nSzuT93Aif8WuEmwdTkkgxsAJBQJEEHJyIGkrFdGo6iFHT8Beg/gr0+mGkQpSSptJZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S6chn2zXfyKMOlexDuI0gab4lH1+Cqa72spqrcX8+M8=;
	b=f3bhpwTPLuRiRcKoWko9OKHdVqmFnDUUjGEDqeJXXVHf+5+4HZKj9GADYX/CQ37YNqwY
	 Huj+tIFWvG87LDmomcHVBcghGsBcOHhGe5denjySMH8aO4PSwEhVwu9pG4Jj/npdTvYa2
	 GriBE3zC6jG7QKlU6YNGMKpJxN54/Oup2gbZDYAw8eKOd+ogjoImqxUEhYxsLus4BqPw2
	 TpC6Wtcnkt3W/78r63NwbyMfymJH9XCj6NTSxbYr+4C7KISPnYjYG/LkApCKHx5x1ea/7
	 c+uO6sjM72iuxwpeaUDMqiwR9sWQ07gTTTr7Taejy5N92VGlweEmSK/jkO/E3VdOHvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r74rfqDI;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF6606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18AF6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r74rfqDI
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2235310eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794266637; x=1794871437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6chn2zXfyKMOlexDuI0gab4lH1+Cqa72spqrcX8+M8=;
        b=r74rfqDI7EAD03xtp25UjWc1tdu6HGk0vozGgIbhpaysC0RTchHxE0oS2Uj3AZh5O1
         jF+tgi0cyzwV6UJ38vgSUUYHMLiohnA9jZlR15jDc8k6RWO/Hd+IG72op0NUmOLoX5wf
         BhYBFKkGo4L/ivdYZZU7hHU517F3RaVXbF1sRVLIdC6afeKl1iRpijC09VyIHesskNey
         eDPTvcUt1LR7uAqSA22MJNnK6358G0j9yunZ+ny5bw4612fUdGMHfvLIqDNFPDK30vCS
         hFhVnAf46l7nbEl81TEcIgM7900zK66EYyd4vbb57FE2QIPqov5FX2P0kPFYw8J1NUMg
         JHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794266637; x=1794871437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6chn2zXfyKMOlexDuI0gab4lH1+Cqa72spqrcX8+M8=;
        b=elqIDmA9tvr4UHc2Kiv6fQVuNA3JeDq75zDjPwKjEGlOyXgfEv0iDW7h2bcoB5PpD7
         rd26dxRiccdpeYLyQ2D5JRjSGiwzu9NkO7xuv3vTm9XOOjH9Hk2Vqwip6tb4XN5dSdrN
         7SDxt3vXWMJszaYArikvbfwxvQufNRY8ndqSCJOZXC56JVcHcbbVgOg85HGGVSFa+1zs
         Aiy4MIgtgehRAPuSJqK3g44yiM+ccTaXnouVPh6mhEKxhYa/x3UYwTJdbOAE0HQMA+lo
         71YdjvqWc3X8fVcCn5RyBVG+xNL/bOTu9svGnbSrXMmQWGJlEOAz0ljhYvppe+MuoqZC
         GIXA==
X-Gm-Message-State: APuU4Z88PJmy1ykyQ9EUx+xlYHRxxcyC0z5NM+pzkfoiCHFBUNOCEULh
	6uUngxHLnmiBcd+3vIwbWb2D4zwqxh5+zmVRv+J1usTr//nG3B87wjMscZ6CXA==
X-Gm-Gg: AYBFou15HgwbYsBFwHKlk4SgMtLcRnI5kJ+vvhQjMOsXd0KAWxqcMqyVC92Fb+WC5Rw
	Tv0GTaxW/7ZyOmkKZ2Bu2ZKEUyUnbxGJ0Tickb14tJ82fRBvk1gCfijUryff5bDhkVYJignkITY
	VqJL5gm9f+jq8TxiGTLcmOAgvPSPYW71cvEWWFQGkwUdzj3cIfEIB2CbEVM1eiw1N6TF/Mnmaf7
	JCtvMj93IUMSZg6Cz43VD++Ic+w/Xpx8eIsEkTZuy0TJG9eydiIOxoY/1LFzgQr6/q6tPgoIQoh
	rBbuadXMQ8Zsljt0VigI5pChKsI39mdbmP5yZFOpvpX4QpMEKs+zHbbSSIjwY7R+H9O+t23stSU
	DJ9ODpQERUNt4AT7cRVH1KfTC2wYsUgVF9oqufMsBp8EtEhawWXVZxLjsQ8YrPKZp2WqPjT7BOG
	SrMOGxhujlJ+XBSTQoQyZoZuwk9GLnBOpsGVqoGptmXm6N7UNecd4WyPTM/C3IHwPP15Yz8+1U1
	F3UjnPWxcMYqag+EHO9K07EOmuZME57jNDGJv01VteNDKwXFSUViirmYglUjCsMF3hxemJHGlnc
	syuQo5wbWIA2LLJ3QpSE/woZvVzzhyIR3eHd/7dQd+ZiaLBJTxgwFnL+BsKQKmwYG39h18tDOgY
	t7o5xGRKE+Em6w4BGCjhvvfw5a15r3bvt4ibrnOCY+GV4Jmddz0mZ15l0g0KLGH6aprs=
X-Received: by 2002:a05:7300:fe81:b0:36c:9af3:22eb with SMTP id 5a478bee46e88-375210e41a1mr951374eec.34.1794266637090;
        Mon, 09 Nov 2026 15:23:57 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:9863:3329:170e:7401])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm1550665eec.0.2026.11.09.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:23:56 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] libnetlink: zero padding in addattr_l()
Date: Mon,  9 Nov 2026 15:23:54 -0800
Message-ID: <20261109232354.3061365-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
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

addattr_l() leaves up to three alignment bytes unchanged. Zero them in
the helper so padding does not depend on the caller's buffer contents,
matching addraw_l() and rta_addattr_l().

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
Follow-up offered in the rta_addattr_l() v2 notes:
https://lore.kernel.org/netdev/20261109164116.2637408-1-dave.seddon.ca@gmail.com/

 lib/libnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index c4a8e694..23fbf5f1 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -1414,6 +1414,7 @@ int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data,
 	rta->rta_len = len;
 	if (alen)
 		memcpy(RTA_DATA(rta), data, alen);
+	memset((void *)rta + len, 0, RTA_ALIGN(len) - len);
 	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
 	return 0;
 }
-- 
2.56.0

