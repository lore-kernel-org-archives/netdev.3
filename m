Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726303;
	b=J4IP1Chhn8H2u9/t5g4xwd6kaipfxpmj7HQBcCUuG6euNNtkJIdYtAVajQI2WT99SADa
	 xz2s4skNdPU/9bLTw9L2tLqzgtQgO9XTu4xpft1pp4klqLf58Xocop4QXAV7vwRBFRr5X
	 EcrO7qLQmeDggZ91j8IaqH/pRCq/HmC2v61bN5/2kI6E8RTeCX8CqjT/fvjK2jYA2jUKx
	 EBwrrNT9EY0TvksMVc+jM1gC6AJsm2f0lt4RZ9WTO5N/RWSiaOM2eYNU53AdLOI83yqlE
	 BYJDJIYwuH+0ZAtEiFwR9fD2Gz/IcSOHAmvu1j2WMJ64f7nDcNeZH51QR8A3LJRe0Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:From:To:Cc:
	 Subject;
	bh=ZadhwSgSv2eX3O8f/pIjqTotPjoAX/jLJi0s5orYwcE=;
	b=DEwMvxtxr+/OBaEjTA1VT9e5hiIzoZhxEh2a+OqI6EJ79ZUHA8w+Nx+S0Duq4AEk3peT
	 zUx3WUceVOO6mfCFfZRttJLR5EWnh8dyTySeMFW9ksFJqhsxMDFS87M1G3zHC47/F5HZI
	 6araQpIs5cm1REEyPqNZM0p9geG45B69JcmFCT6B72uI2HiEngLt+b2kkpnKGa9vgVHps
	 lfKgQ+FPJuojxD8Mf0hpkRsgC8d+XsmR/O0dty96VXfatFEOFYjkIvPZD5cofSOsCY9E6
	 D9o+0CAvP45jgmAT7y6zkYIlSnQUNMUUZIUNCtbfK5fOFWpTR5olSlzvvU45B+fj3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aU17+kzF;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0F606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB0F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aU17+kzF
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2e876f468e5so1477335ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792726302; x=1793331102; darn=vger.kernel.org;
        h=subject:cc:to:from:content-transfer-encoding:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZadhwSgSv2eX3O8f/pIjqTotPjoAX/jLJi0s5orYwcE=;
        b=aU17+kzFTOrlJDzxFDMhQYuyFKS/w3VFNi4lG91gp/lQ3KZsFyA1EySvVqpnKbq7wr
         ZKQVEzCtJGfZOfF0vv7R9rQmm8H834Dhgl3wrm2VbHySR20EVZpot7sGWBl1FeI7Mv59
         v5k69xyZbzm8ZzRA2+DbzZE6zNSUPWXupbmxYH0hyWkzirjmo/ZOsMDOOokleRR8ao/o
         v59lzuZQVb6QV6F8qnrdd/imnM6M0q9+uX5/b7gDkUxO6/jacyE6yeuC9sfbgYTwxs0z
         jmMEtprd5xW8apptoHwt7RONQ77zvRNE1B1LJtQaaQIq3DAPitHvOs47t1dOqDFPZffY
         1iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792726302; x=1793331102;
        h=subject:cc:to:from:content-transfer-encoding:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZadhwSgSv2eX3O8f/pIjqTotPjoAX/jLJi0s5orYwcE=;
        b=O9TZJmTcgHFzy+ZSW0tSCo9xGmy5wRXxjInZTnHIPN3JMnaK79/4QzPYWQhhDelG/6
         hUOpa8vrQLm0OS7ZF1j5iLYRmeReyil/WypD3Mq5JecaGKmaLQjW3av1yFHWgx7F1Zu8
         oDb+87Dxrm6X80JaA3pREwl/5LmTJHNQo5b6NNcF6J1y9gIvM4Dg4xoScCbjn2uLvD/+
         IACm3ECSGZdhpiSXTnO7JINfy5ul6ltVPBIG6yI0P3HJ0dORdE9rmgNEHhdZYqNVfZd5
         pkPuWpDaSZ2aDVzTkFR3SLxxtKiAEnwvG1ZAWHZwO13HYvoPNPl92OmgjJIXM+u6f8Z6
         N2QA==
X-Gm-Message-State: AFq9FYL/RAQXRelWONc95WiWInAkQy2NFFUDySrujVNKIvlqOPOVUupJ
	rswJHjyLBcanwIxowUW/ejSklA/ZaBSH4s40NbV56oBq+yPQBgJ7OouIXP2SYeXOa0o=
X-Gm-Gg: AYBFou2M7CvDeO0uu+uIFu7unZaPY6mhGXUhzHgruiiRXnRNne2b+Hw3CgsRxa9sb9q
	LC32u+l5aiuxUBDHFmNklOg1lO12GrB+jiB45eYLt40lfWQ9rsWeExxmhcUv5dTVr6WqD0exIhi
	dQqoQsPkWYq0M16uK3uHbgxoL6zDcbr+6ldABgKgcjvQfnUmRDDWqTp2gIT/NbgAgPv1I1VnYLG
	2V9Of2/ddiTwbIx9xTq0iSvgcc3BtHFFuarcRbm6HCC52HSjBQ55+9cMCJtyUQBjbo6xGtA96Tc
	cWBKqDW5EBlpul0IMcJzgB5962aMshQfzTiMYfQDochskWhhFWOyMFSTpM9QQm8aUxa0uzZM1Gl
	BRqT5SF1gppiJ7Q5r6WHEruOKutg+vJ2LXiYsdjDlFFIXtBXfKn1bhqCDccrrH2lbGuvkOVnnHF
	7S37W96HwLKW6rgol4jPlveofoHyPEKh/QAZNBOWFNZeiut/oZRCCOB0O7IagWJuLuemQGjUDDK
	uQtOj7ciFNglxSV+SCFSl2PEMzlKDdxamb49obSTRAHctGKv74xmPmSHOcCFCTvnx8K3DkVRQUX
	4HlDQGV8quKzCAeq
X-Received: by 2002:a05:6a20:9c8e:b0:3de:4a1c:a95 with SMTP id adf61e73a8af0-3e376783287mr680352637.91.1792726302195;
        Thu, 22 Oct 2026 20:31:42 -0700 (PDT)
Received: from [192.168.43.2] ([119.234.41.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8889ddsm300282a12.12.2026.10.22.20.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:31:41 -0700 (PDT)
Message-ID: <6adad51d.8fc0b0c9.1ec657.1868@mx.google.com>
Date: Thu, 22 Oct 2026 20:31:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org
Subject: [PATCH] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

cmF3djZfc2VuZF9oZHJpbmMoKSBzYXZlcyBhIHBvaW50ZXIgdG8gdGhlIGRzdC9ydDZfaW5mbyBi
ZWZvcmUgY2FsbGluZwpsM21kZXZfaXA2X291dCgpOgoKICAgIHNrYl9kc3Rfc2V0KHNrYiwgJnJ0
LT5kc3QpOwogICAgKmRzdHAgPSBOVUxMOwogICAgc2tiID0gbDNtZGV2X2lwNl9vdXQoc2ssIHNr
Yik7CgpXaGVuIHRoZSBlZ3Jlc3MgZGV2aWNlIGlzIGVuc2xhdmVkIHRvIGEgVlJGIHdpdGggYSBu
b24tZGVmYXVsdCBxZGlzYwooZS5nLiBmcSksIGwzbWRldl9pcDZfb3V0KCkgdGFrZXMgdGhlIHZy
Zl9pcDZfb3V0X3JlZGlyZWN0KCkgcGF0aCwKd2hpY2ggZG9lczoKCiAgICBza2JfZHN0X2Ryb3Ao
c2tiKTsgICAgIC8vIGRyb3BzIHJlZmNvdW50IG9uIG9sZCBkc3QgLT4gY2FsbF9yY3UKICAgIHNr
Yl9kc3Rfc2V0KHNrYiwgZHN0KTsgLy8gaW5zdGFsbHMgVlJGJ3Mgb3duIHJ0NgoKVGhlIG9sZCBk
c3QgZW50cnkgKHRoZSBvbmUgYHJ0YCBzdGlsbCBwb2ludHMgdG8pIG5vdyBoYXMgcmVmY291bnQg
MCBhbmQKaXMgcXVldWVkIGZvciBSQ1UtZGVmZXJyZWQgZGVzdHJ1Y3Rpb24gdmlhIGRzdF9kZXN0
cm95X3JjdSgpLiBBZnRlcgpsM21kZXZfaXA2X291dCgpIHJldHVybnMsIHJhd3Y2X3NlbmRfaGRy
aW5jKCkgY29udGludWVzIHRvIHVzZSB0aGUKc3RhbGUgYHJ0YCBwb2ludGVyOgoKICAgIElQNl9J
TkNfU1RBVFMobmV0LCBydC0+cnQ2aV9pZGV2LCAuLi4pOyAgIC8vIFVBRiByZWFkCiAgICBlcnIg
PSBORl9IT09LKC4uLiwgcnQtPmRzdC5kZXYsIC4uLik7ICAgICAgLy8gVUFGIHJlYWQKCldpdGgg
ZXhwZWRpdGVkIFJDVSBncmFjZSBwZXJpb2RzIChyY3VwZGF0ZS5yY3VfZXhwZWRpdGVkPTEpIGFu
ZApDT05GSUdfUFJFRU1QVD15LCB0aGUgUkNVIGNhbGxiYWNrIGZpcmVzIHF1aWNrbHkgZW5vdWdo
IHRvIGZyZWUgdGhlCm9iamVjdCBiZWZvcmUgdGhlIHN0YWxlIGFjY2Vzc2VzLCBwcm9kdWNpbmcg
YSBzbGFiLXVzZS1hZnRlci1mcmVlCmRldGVjdGFibGUgYnkgS0FTQU4uCgpGaXggdGhpcyBieSBy
ZWxvYWRpbmcgYHJ0YCBmcm9tIHNrYl9kc3Qoc2tiKSBhZnRlciBsM21kZXZfaXA2X291dCgpCnJl
dHVybnMsIHNvIHN1YnNlcXVlbnQgY29kZSB1c2VzIHRoZSAocG9zc2libHkgcmVwbGFjZWQpIGRz
dCBlbnRyeS4KCkZpeGVzOiBhOGUzZTFhOWYwMjAgKCJuZXQ6IGwzbWRldjogQWRkIGhvb2sgaW4g
b3V0cHV0IHBhdGgiKQpTaWduZWQtb2ZmLWJ5OiBaaG91IFFpdXl1ZSA8bjBwczFlZHp6QGdtYWls
LmNvbT4KLS0tCiBuZXQvaXB2Ni9yYXcuYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL25ldC9pcHY2L3Jhdy5jIGIvbmV0L2lwdjYvcmF3
LmMKaW5kZXggWFhYWFhYWC4uWFhYWFhYWCAxMDA2NDQKLS0tIGEvbmV0L2lwdjYvcmF3LmMKKysr
IGIvbmV0L2lwdjYvcmF3LmMKQEAgLTY0OCw2ICs2NDgsMTMgQEAgc3RhdGljIGludCByYXd2Nl9z
ZW5kX2hkcmluYyhzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBtc2doZHIgKm1zZywgaW50IGxlbmd0
aCwKIAlpZiAodW5saWtlbHkoIXNrYikpCiAJCXJldHVybiAwOwoKKwkvKgorCSAqIGwzbWRldl9p
cDZfb3V0KCkgbWF5IGhhdmUgcmVwbGFjZWQgc2tiJ3MgZHN0IHZpYQorCSAqIHZyZl9pcDZfb3V0
X3JlZGlyZWN0KCksIGluIHdoaWNoIGNhc2UgdGhlIG9yaWdpbmFsIGRzdCBoYXMgYmVlbgorCSAq
IHJlbGVhc2VkIGFuZCBtYXkgYmUgZnJlZWQgYXN5bmNocm9ub3VzbHkuICBSZWxvYWQgcnQgZnJv
bSB0aGUKKwkgKiBjdXJyZW50IHNrYiBkc3QuCisJICovCisJcnQgPSBkc3RfcnQ2X2luZm8oc2ti
X2RzdChza2IpKTsKKwogCS8qIEFjcXVpcmUgcmN1X3JlYWRfbG9jaygpIGluIGNhc2Ugd2UgbmVl
ZCB0byB1c2UgcnQtPnJ0NmlfaWRldgogCSAqIGluIHRoZSBlcnJvciBwYXRoLiBTaW5jZSBza2Ig
aGFzIGJlZW4gZnJlZWQsIHRoZSBkc3QgY291bGQKIAkgKiBoYXZlIGJlZW4gcXVldWVkIGZvciBk
ZWxldGlvbi4KLS0KMi40My4wCg==
