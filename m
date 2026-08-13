Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C774921BC
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640383; cv=pass; b=ta2rpfTZ3ru0H/5OGHKcP//ZgFqWwvQ6WlX4W0k6RFJjPkesHJiP87aUwKupy9lOowCAM9TBQh0pM9yYXps5I+VCQB1bSddrucU6I3xfaqjW88J2BXgptweUieUTIIAxt4TDVwSnb4enG6vPUSdOmSCaSYBovTs6tk2W2kGkj6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640383; c=relaxed/simple;
	bh=xoBdWEtJTPlDLVyNbMab7t+/J7TUwi1z7zZtLQ6klVM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TQIHGXSF0Xu9KIlu3q3OQUMoTUZcz6DxAwhfSMhY28Xp6xN8QCFSWUVtBpE1p//2QTxAVdstkpgKVyYZC42pP+Qcv/TLVRwzHVMVyUG5+WzzDMp9SDgjoj6Tr9LjqCMOJfD+R+dO3DNihzBuZDj+LgMOqp0F7oiA3yW8uGNKcQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eoe0mBVp; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eoe0mBVp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso2053475ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786640382; cv=none;
        d=google.com; s=arc-20260327;
        b=USEI0W/mVLIr4iY9YrjEP6r0VFQo+Nk2XBqYImKpAoruDQ79IkAr9ojqHOT5HFJ+67
         Cg5FQN/dxzrdsNyWl/5wDvuHl8WMmLg4IiM+KYr1pkClJ31n4UzABod6D04YEfQvKNmI
         2G5D5LZOAVQGJPWxRNW05L1qtSRvUKjdiqH+srP//fahDWwOcSAWyU6uWvmyzNtWCUul
         TxFRcylpW6XBRhWqH/X7wdROh9gPG9EZAJwSDq81EBm+rG9PBCUXe2pF9qJOOirVNUG+
         P6EK9DoXATmfpgspmdK/CGsA/MR5He0CfUklu31e/3Uf022kRkLCiDhVYqa6lR+6Y69m
         99Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5PCXtpD2RlzIqld0EEK6YS2HyVzJj+XySKEtASyVQ20=;
        fh=XtWWfWhnJU/p0luRkrXchL70fU7t0u2V5qIIFNsAXlU=;
        b=CbNGFllimijcveVPHja8gXcaXdKryXLvhiaaRhLBNet2VVHou5VJ3PBZ3QjPEDgqoi
         dKbh9hRtL4vkDTthWgODWuQCHv3LMxE+ViZbB3CsYYuTFDOtYMVbxaV2NvCaQB/7Af/o
         ASkJPvUEancLlO/enRezldnwwFcYvkFZOkwWA+nFGIzgHDCQ1P0b3JbfzdrjepmxBgSo
         p2ZxeyZz/CxmjSZgdYZub+F/PvUoJ3zNVw3OAbVX9LQH2gNLkwAj7mWfRBnfCAuoMB6P
         iUrEldjSB/Uu7agjvTwDYbwGAvjP6Phbg2A3cwv9ZGD1U3eyCZmkTEw0viBMcfjclr2R
         ZUZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786640382; x=1787245182; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5PCXtpD2RlzIqld0EEK6YS2HyVzJj+XySKEtASyVQ20=;
        b=Eoe0mBVpeSDdi7T3XLAxzyHYM/od6gilK0FfqVVaQnZJYb6FAffj76MwK44CEVzxo2
         lXpLCcfWLZ8F4f6y7n9iprcEXpf/LB/QinAUhfqR85T/QRXVJw1zfPbfA213B4qaLDYp
         atlsAA3O4a09qU+CdwO0K84bocjkDq/yaCphvjK/i9Lm2miLaRe3Ms3JgWyx3fyTMYZY
         G8l+iTgvoJcNCBROZuHQp6E+SHjZpCP37JK8UdS4tVmvPl3nhciAGcSLLMV3Em4vNSGf
         gsekNTEOAczWdL16NLWztGmQ4GbXSqn9UvXhmLELIa905JDObZu1vX4pO6TOTFFZLVKN
         66iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640382; x=1787245182;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5PCXtpD2RlzIqld0EEK6YS2HyVzJj+XySKEtASyVQ20=;
        b=DoYuWtn0tQT8Oadz6V9Ysti3+e2N/w4vbcs8G993o01+XNdOmJMPj5T3+qBTvAIVDP
         y6I0z9ro8V5cFE+31P+v2Asy5ktpdrxglBQnl4pGbAtOI6YYCtlzXovjPMWxL46hTghZ
         3x6+3110AAHTWdSeyaK1CuCtg0bxZCZEYk+mvwYrt2ZfoCWgJyeTB4LWSO7FMCzgJuYx
         YuNFPDf8a5jg4HS2PsSGnYMpxGRemLxdAoAalxhmF0xZThU6SrlvYXtdPrXKZQRV4Ev8
         txSCu7JpHCrPz48HsFeuFMW4uUMEwmcc2U0+5gRKpn17Rd0GThJxTf433menq3SH1HqU
         NnEQ==
X-Gm-Message-State: AOJu0YyNZz9UHs19WgZzoZbqzPWCa0w0FMJyTxbF7gwLQJeFwT+Pm2CB
	Z5H2LzkbosnRFWNcdd5Ck4umUas6SjYzUWtaiOVZMG7nXfl7QrDMH8apJkz8swmweNN7wUPU8wF
	hWK88aAifPSG/esHe4t96+709pt2AOrM=
X-Gm-Gg: AR+sD13JmGVxYMv1Y3EAZnEZmWGOuW3nClHghAFYKN6/QO0+DycUAb3560fR0cotz31
	sZCXPsZ2lYbb9QrLtBCpNvrHL0yYA0Ez1Uniz7RjOG8gQauWp7DveLsOpwxAxtEzPTRjSZD8WvX
	wxHEf0mbMIHdLCqUmwOltdSZRr8OSZSUpGv9V9ViMObS8+6pvMCtNSxoAU9vmOzaSGjEKhZlAgf
	nfjhogl7fwMzQF3GPjn9Aw7GsMfxMIivwUyLHsF7LQNGQkCQQ4Anw9gMKyztWzfD+fwfsNrDgP+
	fy+0u+Kg7AmTY86IyS5+pYE5KJiPHCTOoTeHS1PJ30ccOUkzWo2stx4y4N1rZfEQwYM7TGKDh/p
	xs31IFyKY4Gf7Eah52OiVfX1diwkeJd2wSw==
X-Received: by 2002:a17:903:40d1:b0:2ca:304:f93e with SMTP id
 d9443c01a7336-2d37ebc2df5mr97346755ad.22.1786640381605; Thu, 13 Aug 2026
 09:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joas Antonio <joasantonio108@gmail.com>
Date: Thu, 13 Aug 2026 13:59:30 -0300
X-Gm-Features: AUfX_mwucnYyIHD3IqRl-RHeVt6sDZhmNV6nBBs18XEE_p_RDm2X2qFPzlzle-s
Message-ID: <CAOCBhwHbcnuzP1fz=JLqeRA0xNU=QdqppeRy2y=wqhJR6k_VRQ@mail.gmail.com>
Subject: [PATCH] ipvs: fix integer overflow in ftp helper port/address parsing
To: horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org, fw@strlen.de
Cc: netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_vs_ftp_get_addrport() accumulates decimal digits into a __u16
(hport) and into unsigned char (p[]) without checking for overflow.
A crafted FTP PASV/EPSV response with an over-long port or address
octet wraps the value, so the helper configures the data connection
with a truncated port/address.

The netfilter conntrack FTP helper had the same defect, fixed in
commit 2b413fc689ba ("netfilter: nf_conntrack_ftp: avoid u16
overflows"). Apply the equivalent fix here: widen the port accumulator
to u32 and reject values above 65535, and reject address octets above
255.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: CyberSecurityUP <joasantonio108@gmail.com>
---
 net/netfilter/ipvs/ip_vs_ftp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index b315c608f..9e3e005a8 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -102,7 +102,7 @@ static int ip_vs_ftp_get_addrport(char *data, char
*data_limit,
  char *s, c;
  unsigned char p[6];
  char edelim;
- __u16 hport;
+ __u32 hport;
  int i = 0;

  if (data_limit - data < plen) {
@@ -144,7 +144,11 @@ static int ip_vs_ftp_get_addrport(char *data,
char *data_limit,
  return -1;
  c = *data;
  if (isdigit(c)) {
- p[i] = p[i]*10 + c - '0';
+ unsigned int val = p[i] * 10 + c - '0';
+
+ if (val > 255)
+ return -1;
+ p[i] = val;
  } else if (c == ',' && i < 5) {
  i++;
  p[i] = 0;
@@ -222,6 +226,8 @@ static int ip_vs_ftp_get_addrport(char *data, char
*data_limit,
  if (!isdigit(*s))
  break;
  hport = hport * 10 + *s - '0';
+ if (hport > 65535)
+ return -1;
  }
  if (s == data_limit || !hport || *s != edelim)
  return -1;
--
2.39.5 (Apple Git-154)
