Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5F371898
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078993; cv=none; b=EZ4rsm3AI4lOSaptnUJueaaqmeorwas5HdSI0+qs0bA6Q/qluEo61BF+23bwE2k+9OV86L90A1JrA6647Im1iNNwr+W9elAxUVW6gLImeNjaLra7o5mD6g39QrgaCrqVV5O++wtBwhLYNjL53RyYnCr+2pM7G3hRv14/JUuZiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078993; c=relaxed/simple;
	bh=tMXm0pzsM+iXwr648/ZLahDO9tvC5hPdOCn+CYpWcA4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CcoyNfIwDX0HxLfzgBnATdZ1KDy3XEuDLaNHRwalAjH/g4gA2WqaCv4PwfIENK/WGDn+rtqEB/NrevJPmCmblYc6Dl3VpTrnKGzrPqUG5KuJdLhjpbmbXojMJ75YEQNxMwcSEIy/s++zGR2STHMum7qGHieYcMhZA3czjAZZzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK9cTIiu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK9cTIiu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eeba68948so2814577f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782078990; x=1782683790; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeVFzprPfqrGtTtTEDPqb7OW/w+ehX7IydHpjIBUQYU=;
        b=TK9cTIiuRbuz3TIM53Pm9dJH299yE5dhRwr+s/mLjNvZIRkWa67r594WMzpYZOgOQ2
         eWrltFwt2nIYdw4pS/iOXUrrSLWX7j78ZmKnaRytHERwdKGU+KRmFuKxHkMuHkmDBWyZ
         l1T24OhCJPRwshHp79HyE3eT/mlBb7eh2zSOwAHlQACYFWSMcd5nPYv3X9jFokZq3aHC
         DcRPmglEwWsZLIomoWKiIUA7mTlcM07qCBZ3yYLddsV3oEIKMJR5aY8Wont6lYXKXPsL
         lqCPsL96fyN9qdyySgPNtVtOmEJwJiiFmmqR3X44oZQj4emCqGO8dcBYx+6AMDXC1gmS
         e3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782078990; x=1782683790;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeVFzprPfqrGtTtTEDPqb7OW/w+ehX7IydHpjIBUQYU=;
        b=WZoMtGxo4H+J60OjVCBIZGgNjNv2Vq6QGKiP3n+pW/fmLeqEiYqss8WPr1Fv95nmyh
         qRWiSI1x7VpF1VAtCtFZ3C/dzAeU7VecRuzrbL7FHPr4vEoYh35Kzboj8TD3TpoXsRg0
         HCt5UjICLD1JWwi1eeJLc3qoZs1sXRASJfwwU5+3/kqNpHmOymD6SbFV2+zGNumKAkCt
         d5N4yIymjTMNJfpnwoiE4elh10JfxN0e5hqeqZsaC6NayrBGj3eRV2QmCuOkRmqQc//1
         9iDQmQw1AnfDxdnuxziGJ9996SH26aDBRpbHHCQJCNvfvnyeWCKLr7VfYAA8wzHpGe7l
         9z2Q==
X-Gm-Message-State: AOJu0YwirnIVReNE9STKSZhEt9g21VNV88Gup69dsztuUI2Ks+KmWELp
	iuo+TjHk0fnIyXZAGvCRVmNh6gelmHiwaQobiCOeOfzpZI73Z35TezKX57dEcA==
X-Gm-Gg: AfdE7cmjGe6POaOZ5TygaDMaZEiMPPAtCA0NZxGqhrRY4gBwVc/hNTbWZn8TkkezF36
	WasDWi0hUS60+rDGyRmZTUDmZgXSMyScuwMmiCIlEuM8kqqixNlkZIiv4I9ciYi87QIdgtUT5cU
	6VtAQvh4+Fbbuq0FsZrMywzb8jJycwk36p71eq31Iw580BF/rwZEchA8ysuOS1qsxQPjgzIFi2J
	UN3Kn0XFmHQmTNtn0ISurdp7fJjuS15ZmLb/o39LtEGAppXxNbiwDDcbNzalqgCXEqCk12Lwc6e
	2L2kJKwanK6XaqEGaIhLTnNUNiPWZKYf9NIp1Hck8CpeUfH5J2/5Ph8D1rZzLrcUiJohPqYVu7i
	A7XfY2nREJOytAun9kMZNQXDn6UlrARAJJLL3/Aetx3NARq5i3Ce8jRdICW7bcv1wjknKJfLl/u
	HcwtfSPMm3kuT/UDmQZXs3qFmuxYqc7ckcrW8AdqcSZA6oXmvnZSprqJnILwzwyTtWYQ==
X-Received: by 2002:a5d:4304:0:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-4650853530bmr15423366f8f.23.1782078990004;
        Sun, 21 Jun 2026 14:56:30 -0700 (PDT)
Received: from ?IPV6:2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4? ([2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788282sm29244387f8f.17.2026.06.21.14.56.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 14:56:29 -0700 (PDT)
Message-ID: <ca8680ae-82b4-4d63-823e-d9e808b29f51@gmail.com>
Date: Sun, 21 Jun 2026 22:56:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Dmitri Seletski <drjoms@gmail.com>
Subject: [PATCH iproute2-next] "ip help" wrong output, exit code.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Changed output of "ip help" from standard error to standard output. And 
Exit is now 0 instead of -1. "ip help|grep bridge" - now gives bridge 
syntax instead of flooding user with everything from "ip help".
---
ip/ip.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index e4b71bde..4627b61c 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -56,7 +56,7 @@ static void usage(void) __attribute__((noreturn));

static void usage(void)
{
-fprintf(stderr,
+fprintf(stdout,
"Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
"       ip [ -force ] -batch filename\n"
"where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp 
| link |\n"
@@ -72,7 +72,7 @@ static void usage(void)
"                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] 
[filename] |\n"
"                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | 
-a[ll] |\n"
"                    -c[olor]}\n");
-exit(-1);
+exit(0);
}

static int do_help(int argc, char **argv)
-- 
2.53.0


