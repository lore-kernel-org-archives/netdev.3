Received: from MTA-07-3.privateemail.com (mta-07-3.privateemail.com [198.54.118.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA3347529;
	Sun, 19 Jul 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.118.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484678; cv=none; b=BE4DJj0xNJDh5NhNy6ewsXmo4VmzA1aL8l4uCBZ6jHkc1fNXffF/etUnAXGS5AdUqVdwTAWkN2i6o/kqSDLYq2SQSSq2dD/mtCCT5b9Bj16cAO5I5wTPcB0V3wXKu0XQPRQh+AcdLG2ifpwyCPfGvQdiCupVe0Ch5N4ELCA8SEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484678; c=relaxed/simple;
	bh=Bul3j/OsqTw//nRoLthgWciTE7FwKi3LL1jaArRj4W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JW0fwe2xtusYAxXOdbd5jEQA723VmGYaI1rWz/kDqaR4cHN/ELPJUowDqs5vVwt7Nl5Vnt4q1kW2SBx8Ge6ZxI6Ve57dSuqi4/DIdhpvwRWqG15Gn655ZfaoZ1O6k2JhnOUD8gEP7VSnRr82lJ4pa6NajNlvftYJH6rcnNYFNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.118.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	by mta-07.privateemail.com (Postfix) with ESMTPA id 4h3BXT4njxz3hhTG;
	Sun, 19 Jul 2026 14:10:49 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] nfc: s3fwrn5: support the S3NRN4V variant
Date: Sun, 19 Jul 2026 20:09:38 +0200
Message-ID: <20260719180938.43341-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5d26f3ae-1287-4440-bd38-96c9900f16ea@ixit.cz>
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net> <20260705190621.128257-3-jorijnvdgraaf@catcrafts.net> <18c3e13f-88e4-458e-9f57-7aceeb1ce1d1@ixit.cz> <20260719142241.12640-1-jorijnvdgraaf@catcrafts.net> <5d26f3ae-1287-4440-bd38-96c9900f16ea@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello David,

On 19/07/2026 16:56, David Heidelberg wrote:
> now it makes more sense to me, feel free to name it as calibration
> data.

Will do -- v3 will say "RF calibration data" in the commit message and
comments.

> I would suggest to introduce something as a calibration-variant (see
> ath10k code).
>
> If I understand right, firmware location path could look like
>
> default path + driver vendor and model + device vendor and model +
> revision
>
> /lib/firmware/ + Samsung/s3nrn4v/ + Fairphone/FP5/hwrevision.bin

That layout makes sense to me. My inclination for v3:

- request the files from a chip-scoped directory:
  samsung/s3nrn4v/hwreg.bin + samsung/s3nrn4v/swreg.bin (the existing
  parts' sec_s3fwrn5_rfreg.bin is untouched);

- an optional samsung,calibration-variant string property (modelled
  on ath10k's qcom,calibration-variant) that, when set, makes the
  driver try a device-scoped location first, e.g.
  samsung/s3nrn4v/fairphone-fp6/hwreg.bin, falling back to the bare
  files above.

The variant lookup can also be added compatibly later, once a second
S3NRN4V design (or a diverging FP6 revision) actually appears -- so
if you'd rather keep v3 minimal, I'd do only the directory move now
and add the property when first needed. Either works for me.

So far I have seen no evidence of per-revision or per-region variants
on the FP6: the only difference I have identified between my two
units' tables is the vendor software release (build-date stamps).
But Fairphone would know better.

> /cc Luca here, as he may know more about the different configuration
> data shipped.

Luca, two questions your way:

- do FP6 hardware revisions (or regional SKUs) ship different NFC
  hwreg/swreg tables, or is it one set per software release?

- could Fairphone submit these tables to linux-firmware? I assume
  the redistribution question sits with Fairphone/Samsung, and having
  them there would make NFC work out of the box on mainline.

> We should assume the configuration will be shipped with
> linux-firmware at some point.

Agreed -- that is exactly why I'd like to settle the path scheme now.

v3 is otherwise ready, including the Fairphone 6 DT patch; rather
than sending it right away as I said earlier today, I'll give this
a few days for Luca's input and then send it.

Thanks,
Jorijn
