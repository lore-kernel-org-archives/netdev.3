Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400590;
	b=N5LelOJvPNjvLovsgo/UpdLf8XmfNGrv/TWCbKGvkfDGnEBv+2BoyefoSkV/LfDOh8pf
	 GFMPk6YtWUHsBqFMt2sat3NuWGuo9kpep7a4Xn0LcYGsNQEm4nwwdULB76p1KC1vsZa1X
	 7hdC4OLytkyLBilYtXxoNe3iUpoQvZOH6vpu11OnNIlyD6o/0DUAvEe6n+WFvXRaYOWr1
	 3wYMQjEfKJ9QDRydz5o+ThBlntWTreEQHelzNs/XySmSMtUUX98HBobawS1FT4QkcJ/IS
	 eyyb1SUTtNV74rJPbkSRxxP06jklRHq7uoozkd7pT+aMzMI2YLcVEJBBz9jTKDczONQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400590;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=5kvi9keqRBIcU6BT0G7HR9eg82C0nTpkyhhRu9uuWrU=;
	b=y+Y0NnEVLm8+kXtVYqmMp2WZn30zpw5aK/t36tC0zkYehiUEbOwBuFS1UGyfhu4IJOg0
	 rS+YLZNL0zhTpYK96fE3UydCb3EvA8099udX9xSBH7ExgX2yIKiNruFui5myqvAujzBO7
	 bCX50DaCjAj6vnKmJ7qZ3EGXx8Mo71wQbB2lwgURdfjIzvabh0HNUbJo0F2zT76v0YmqW
	 D6w7O0rgFzbsahM1FViTc5cyA8bMswnl8mFJFkJch0kEy0kbjr71oSNgTdzatpTHUmG74
	 I8Fr2o00KUWcjUJxY5/NAAQ8NH233rs597krjkQWhx3ZoQISQZnUmtwHiWzEwsBGkjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JFR5gOyh;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC03606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC03606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JFR5gOyh
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1434502a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400589; x=1795005389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5kvi9keqRBIcU6BT0G7HR9eg82C0nTpkyhhRu9uuWrU=;
        b=k0RJ1aaimkd6Olad/qaZe7olyBQ36yjOfn1fd+7eirdnN9HYm87W3epE/hTfhi2UDE
         l8dR3FOMkC34MUYoxSklSIftfMMW7Q8GKdyJ4vxHKsYxs4jiHft8+ctRQWxUrjAxNbYP
         lBvw8SOc4O5Kkx2EBlD5Yt7zj1+aAtGM4DXwDEgy8MyVSYOwtKqW79FF14YDOBuZvH+i
         yPEIE7OMO0Fmme2KTcwNgoJBdrdd3baHqQ18il/1X7s8aVnGGjrIqkWvx6Smy8w4EQBT
         pxC0Xv/9X2r396JSsFspmqvJJzIMhORzUYF2Ak1+k3iBY4VDUNAORNtFvS+jtIM58y9b
         4lAg==
X-Forwarded-Encrypted: i=1; AL+hErHKdbXD5UtXbDb12h/b3SpUt0f3IW0X/oJ/8JZqecRQ/hcLOt/xqZrOslctv3PIaWNcOFrKPKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IbM7D+/tmp4tUUMOq1LGiKywQgghSeBZdDv33Bm/Lr88wGO9Z
	qtkQFI89KilCB3hX05MWBBXnUkrkszaul9FWw4GUJjgPtYH1KjdRuW73A6oT44Ya40ltMV+balT
	5dw2qgFQ5d1QOFF9oBHB2iCAAmm4Q5osapEIP2yUsyK24Tm0fMEZtV+GrkkVYgxlXKxllWHsfi1
	uPtbjELpXEEoq0IQbJtVWVOPta6mCK209NfE3+E7m3n7uspN8ZC2/dWKgjpqBCgiDl7uUOxR38H
	RNauD1/q5XgEHgv
X-Gm-Gg: AYBFou0Ni/Lt/tQu1Y+sZVRHEsWCqOw7UcGotEVOlKjrGDxrpXZlj6xipiXMGit/HXh
	XGx5F+F2tmH0e+hM5KejBU+IMlTX/mqWdhmGH5zJX+T2sWiuKTBO0U6mpO26H28CM+k3dzkjUkx
	RlCcRTC8iH9b0btl/eHDo8LVR7B7CJ/FMBBMHe7Imf0wJs/ITl41U9qv2FbUf4vYhNYQC+LCltd
	Sghv69L962gEI45+rsTdOixI5MRjsMIu09xRRKN+5WBCqLyO33kZnA6fuAWQdeKlIlrRXjQFUv+
	3o5QlGsQk4WtZxw9YbHh/QK3+BmjwesDwlTUTJL/AYaxT2jhWMulhvGI2SzRDeIh3PIxFSbwJVc
	SDoJpidLHdkMZ3dF4N7QIC2CVdMlq/2EfP8FqgpbVpYg5h56zOfauayS+hyr2SAYlm4SJimxXO0
	OiOLS9nOJF9YB+rNzPhjUcM2JPqOZMUGrG4m0=
X-Received: by 2002:a17:90b:2d03:b0:3ad:a17d:f46c with SMTP id 98e67ed59e1d1-3b182fcd3c4mr2184169a91.62.1794400588969;
        Wed, 11 Nov 2026 04:36:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b182e51adbsm636683a91.4.2026.11.11.04.36.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:36:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso3805119eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794400587; x=1795005387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5kvi9keqRBIcU6BT0G7HR9eg82C0nTpkyhhRu9uuWrU=;
        b=JFR5gOyhXIQUuLavdPb3NXOfq3e2u3GP6NO0lLWjB4wSZAGSE/akdS9LMarqbmOc9j
         q3AcKCGDOt2q60DSjuD5cH72sVqAI6WVsM+IpkStoS0ndODMhsvvLswNOGtoRnhpe4Sn
         EX2gGFHIPeZki31hcrR5a7iLAnoAt6mglNztQ=
X-Forwarded-Encrypted: i=1; AL+hErGtR8FN5HusG5ofiShTpooszuX7MEBa5xAwqxy0We6psy8vwKtbrd8ZJjwZUZi7lsgv0ObwOSo=@vger.kernel.org
X-Received: by 2002:a05:7301:428e:b0:369:f035:661 with SMTP id 5a478bee46e88-37685d731fcmr2268382eec.15.1794400586960;
        Wed, 11 Nov 2026 04:36:26 -0800 (PST)
X-Received: by 2002:a05:7301:428e:b0:369:f035:661 with SMTP id 5a478bee46e88-37685d731fcmr2268348eec.15.1794400586131;
        Wed, 11 Nov 2026 04:36:26 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm15159947eec.28.2026.11.11.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:36:25 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net v2 0/4] tg3: Bug fixes
Date: Wed, 11 Nov 2026 18:09:12 +0530
Message-ID: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset has 4 fixes.  The first patch restores probe on 57766 when
the 31-bit coherent DMA mask cannot be set.  The second patch makes NCSI
PLL lock on the TLP clock to fix WOL at 1G speed on 5720.  The third
patch fixes ethtool -i display on 5719/5720 when NCSI component is
missing.  The fourth one fixes a possible heap overflow in the NVRAM
write path.

v2: Addressed Sashiko warnings on:
 - patch #2 such that the PLL clock bit is set only at system suspend and
   power off, cleared on resume and at probe and updated under the APE lock.
 - patch #4 to reject a zero NVRAM page size and to describe the buf advance
   fix and its reach.

v1:
https://lore.kernel.org/all/20261108065526.710152-1-pavan.chebbi@broadcom.com/

Pavan Chebbi (3):
  tg3: Don't fail probe if 31-bit coherent DMA mask is unsupported
  tg3: Select PLL clock when preparing for shutdown
  tg3: Skip querying for management FW when no NCSI present

Shravya KN (1):
  tg3: Fix heap overflow in unbuffered NVRAM write path

 drivers/net/ethernet/broadcom/tg3.c | 72 +++++++++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.h |  6 ++-
 2 files changed, 69 insertions(+), 9 deletions(-)

-- 
2.52.0

