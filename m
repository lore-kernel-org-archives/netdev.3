Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450B1AC44D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911121; cv=none; b=Fu/S4fFGwzRwAHgewwq25Ibn+sf0L9dXwV7iRpl08B2rPYVaPpn+l1koQnqiyiyVssD0RXMSZAY3DpGDUNXTBJKBde26YcjGev/OBISqqATglGRNiwuLbdWcaf2ZnNPritqH1NjDD2nJ2OBjFRNPStuf2Wo2ITFgfa4t/GQDipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911121; c=relaxed/simple;
	bh=6mIWYgtBuvcvpGsKXHdT6T+Rc+aQoXZ6wIGZxKIKKo4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e6O2cB8sVdF2c6LYMxGexSSXb36e1GxF5RUQyYpzrFs5m8YU764guX0CLHgkFWh/weWd5zi/d5vivy+cM7+26vBmZZBR5tMEXtUTHBN5UUz+UJZy2ybNkyouQRe3826UAomQYbamE9BmacRQvsg41VLeqGx7lelUFDsT9UHfZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCeTXk3T; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCeTXk3T"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9399daa3c8eso256416085a.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911119; x=1789515919; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r7pdQ+IQhQy0RxIIxOjPMghREM5a9DkR/NRAqDgtkYw=;
        b=fCeTXk3THYcBP8eev63vYdDgskey8AJJpfRiLaFzIcEtdjZK6aYNkIzEvlqgi5HvFV
         nmjHk4zUk/ZPj9yFLU77+f8vz0CVB225I1cBGp94aaXSK7QOVVlQhQ2C74eUlwiP9Go5
         SXfhknL5mLt1OSN4Ezjnlw1VAqVESy3id2liY6BqvkQr6rGrsIHKVocjTZ29e4FfmWEl
         ZR2K/FKe2+meZtuDrM9qGsffafDQZvq1NiV7EgF8Wsub0dJdnSGHocIfpXkzO6uBCT1o
         mvLJKDdFID1bFPFcKetus9SqK9GSGTOqMb6x390GQ40eZILW5W0fDckU4zseLMz6JEbU
         Z1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911119; x=1789515919;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r7pdQ+IQhQy0RxIIxOjPMghREM5a9DkR/NRAqDgtkYw=;
        b=rImbIi+gjpJWwe5Kn6sQWoYOV9jjGaAiMsEXI7UYJUGmEX88lSxuOHkmUfDo54hB5r
         ME3K/e8b/tooMkERUT/y9v/ptpqCpJq4t1iHfRK/YRwMOvumwtYIX5MsyoNIjy5gEHPE
         dB02xKIoi+HFdfo+ReQTycdt3Ad5EI+j4CTSJw5M8CkjadAu8ZfeJZKSWBfs6x1NtHm2
         lvMxtIBb6Xi5Kxmvpj+iUgOZEABhSQB4ZUibd/aBhajYLJFm1Ker+uSkHTOAfQZD5jOY
         ls0nWRT64jvy1LNG3iw50xglzj5bV9BVDubJHjrvjSULm1gFTaqs9E3o2eXJuHwMNZfd
         vEWQ==
X-Gm-Message-State: AFuF++kkOPkuSVjW1tQo9rfk6J0e1wTGY4aP5p6YmXAPFdVFuzAiryRL
	sk9Lt1kgGJ6SVTVanXDAlJVPy7LYo5e9BHMCGI+4d7XwceD2cuD5EO4c
X-Gm-Gg: AYBFou0R2WMHgPzlK0bjxxCzjpmIYrVWlXY7PSC3rdoUDNXtcjJ/0j3ff6l1Bqi73xd
	N03B2L52Jrfd3OpBG5wEO988zZAku6xnz78UaoS89eEMNZRjcCGC4Fbfy6uoM2rXl4wx/A+j3Nb
	q1wRl/JT57Tit/VNVXRqszqzggrFdcjMHqy3gFrlPJxHbUKyYeu1cG5nq1XHm/UpZ8MBvXR4IVm
	9KvzxVx/e7UMz83XoESa/OEi1OaMLlhx+A2y8G9X9ycPanDxjlY9DzG2u7AqraSpKCUDKJ0pLIe
	mPF2MEsTZ12qEX95we08WId2MbYrg8TqHJygIdyJ6h69/1pFqhGp3T3o5G4vlo++a/xm790Wrvz
	71yQ04R1ZabMkOwGQiG1/VyWRHMflS/2AQPflyf1XD1E2vgvRfjD6PFi5RB+iqBzKbC/j8R6Mpx
	+9QEB/Cpj3XZzis5no0QTfF3I0stp+hWV0pIlyfI+xigLLA17LBfT96zEoM10Eyko8YN2RZ7Vct
	E/0wvyUdg==
X-Received: by 2002:a05:620a:3725:b0:937:3aae:1385 with SMTP id af79cd13be357-939803241c0mr3039277585a.11.1788911119038;
        Tue, 08 Sep 2026 16:45:19 -0700 (PDT)
Received: from elster.cvl.swallow.glass ([2606:8e80:692f:3320:980c:c29f:b4b9:c06a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939aff54ae0sm551872585a.8.2026.09.08.16.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:45:18 -0700 (PDT)
From: Taylor Bates <tmbates12@gmail.com>
Subject: [PATCH net-next 0/4] netlink: fix ynl spec tooling robustness bugs
Date: Tue, 08 Sep 2026 19:45:06 -0400
Message-Id: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swtphEj8FfFgk1VXZCvZtFRK/
 92ox2GYWWFchA3HbkXhWUxGbdDvOqT7RW9MkhvDOx9cdAd665PKOExWlc0oB59jiPuUeo8WvQp
 fZfkNT1CupLxUnP/GpuHBqX5/2LYPlfBxs3wAAAA=
X-Change-ID: 20260907-ynl-robustness-d62d9693cc12
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Bates <tmbates12@gmail.com>
X-Mailer: b4 0.15.2

Hello!

This series is intended to address several robustness bugs found in the ynl
tooling and the netlink-raw YAML specification.

These issues were found while writing a netlink-raw spec for the Bridge
VLAN family. However each stands independently of that work, and fixes
bugs in the parser that can be reproduced against the existing spec
definitions.

The patches in this series carry Fixes tags, but are all in developer
tooling and have no effect on the running kernel. That is why they have
been targeted at net-next rather than net.

Signed-off-by: Taylor Bates <tmbates12@gmail.com>
---
Taylor Bates (4):
      netlink: specs: fix duplicate if/then keys in netlink-raw schema
      tools: ynl: reject zero-length attributes instead of looping forever
      tools: ynl: stop find_kernel_root() spinning at the filesystem root
      tools: ynl: fix uapi generation for anonymous enums with documented entries

 Documentation/netlink/netlink-raw.yaml | 31 +++++++++++++++++--------------
 tools/net/ynl/pyynl/lib/ynl.py         |  4 ++++
 tools/net/ynl/pyynl/ynl_gen_c.py       | 13 ++++++++++---
 3 files changed, 31 insertions(+), 17 deletions(-)
---
base-commit: ab217fbb9b2169ce677b09a66558d5c3adcfbb76
change-id: 20260907-ynl-robustness-d62d9693cc12

Best regards,
--  
Taylor Bates <tmbates12@gmail.com>

