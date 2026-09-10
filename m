Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56E38C42F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073366; cv=none; b=V59lGf2U2xUR6711OmwjS8y12i7KtHwQtxjPRvZ4WP9PWwPig1dG/7MVYx1ac3Ruf7J/qKfFmZcrVfo6UBreMyeEeJgvzbDMUaf0ZJ59kfIiE28+XOQxlI+bixB4NL+PdBQT17xXzcpX+/HrKPK5mBgSztnwXK3ghOi+zqfPpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073366; c=relaxed/simple;
	bh=gUckIW+EHn+RDkTms5ptK58W6fnobAQfdWsm/8/18fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9xE/pe5mx0XAXB17Vi5SE8kc9mXP7zKhOcVOkcIoTY8DeOHaKhDeSrvW6QkfBXgzdABtIhrxG/jPNs0SgTxQ8FYfRhRIBvVZHLQX54uKFJL72+xVURmEiYdwchAAxASo1A+kG7dSeV/1On7K1WEdXzQag/6NSriyvHwSjDp24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FJvYqqct; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FJvYqqct"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so2191735e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789073362; x=1789678162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LD6/nMf/SCzxFaM5TR830BIT+ow88In2rb2lR6a4o9Q=;
        b=FJvYqqctzWGFi1odEMtCbjcMArUSHlxqI7qXNKvlBhKvgeIVRwM35tu6Y+4yaIYY3w
         A4P8f1dMRBY5WUU5gs6bjiqMpCGASD2yGN2KiRy7Ij8bw3C2DzPA1vV5hJN9uZQQNQ/N
         EyOzO/+RvZRIN9LAPt4U0ZwimQ8Ycsx3aApcVq9gb0Gpu4qnBaO0VYcEoFUmN8j95aMb
         8GTyLASrD8HCtkFgyfQt4qdFEvMAX2o2EYwB+OiF/PSBPrFY3a/dMASsyLZoF7Zv4w/Y
         xWQC5seq98MKyuJHJ6z7vU6h1+A22Z+/MLj8NkTDX94fP1NxZ/JCcue20rgeZyrWJvuH
         Lw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073362; x=1789678162;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LD6/nMf/SCzxFaM5TR830BIT+ow88In2rb2lR6a4o9Q=;
        b=PATeUiBEWIXkmfrT4TALtc4ZhJv8M5r5yxv21nXYbKkowMGC64qE4P5QmQ9cAs4OK0
         +xup47h5AT9mq+i5pgcFVgTOS/1dp6komrAciDtny809S8N/5A7hdfjynb+QkeJsrBm8
         T01jZFQJvbkAdWutXn5e0LPS7PpZoTMNW3PdrZVx37nYdgGR1FLJSlwwIf7pVohhhd6p
         M9jcwIBeTcl87bGj0qSlmCWwIPW2wtPsnyXYtHGPhkznKrUmpzvg65bNBW5VjkVki2l9
         UaSX0NfSl0p2jDf7/mW1yVpFJSlABR4FVLVE/kVtjsvnu0T0hPcS8lLPKdjOpQH3917s
         rdmQ==
X-Forwarded-Encrypted: i=1; AKwUvByP5YsX+PzyrPEwOFQP/mECOF6ZCc4gxjlYLF4iGNtDEHPlOlM5qYUktLlXB4QqsJkRByvWrAI=@vger.kernel.org
X-Gm-Message-State: AFuF++nDtVt7G4fCYUU3sDa+KHj/lc6p2VOw3YOj4S9DBPGnbe4aQP8x
	remp9ECJTkxMhDpQsH6F4gyvrMweuIjAdpKBGRWc3gEUEqbhDP2A2baKTjU7ngaoxKU=
X-Gm-Gg: AYBFou0UMU5Fxq4Z1aPz2e+yGIPw73zDLJUWQYj+QHGnEUJLQKR/uiFyMMOFOWiFggK
	FUF067IhvkiSOkQEfvAJfqYBe1CXDSaDU7jqr4ax3Gsu6eNC2DwkJppNKrSHLqa4X09+a+MTewl
	YB3UEWqzasEvkWV/tfYMpUCujFHGBEj7YRLrL5sh9oN/pTO+jFJIQQzjmVYs7MMOxOZUOGVPa+R
	LkNvI0knfy5fH7nKpkEj++G8FLbhoEMk5CwAI2rcoVWkVzIlWwfQOeyeG11tpXVYg34pbyAf/A8
	7jVOkF6QXz8e6n0fTP2e2Zizyjjr0MSu8VGHiJz1G4Zgu1W2sgywHJOxABjXfUeQYUE+gFu75So
	Bu0XNIt19TcEsyrqyqGNfAe7810Hhj16XU9uKf8L0hijHnCoAaetMhFqQRytKwMxU/HYIO0pQiN
	fY546mHl9CD8SR8VDbUmxLCGH15KqU/EsLagiyo0p8YGtFMNPwHQ==
X-Received: by 2002:a05:600d:644a:20b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49e619837a5mr6892535e9.6.1789073362150;
        Thu, 10 Sep 2026 13:49:22 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35f3d9sm828813f8f.35.2026.09.10.13.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:49:21 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aleksei Sviridkin <f@lex.la>,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 0/7] net: mdio: an MDIO device driver for the Airoha EN8811H
Date: Thu, 10 Sep 2026 20:49:16 +0000
Message-ID: <20260910204916.1979445-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <44f163ed-8362-4aad-99c9-f8709dfbed76@lunn.ch>
References: <20260908155707.4164559-1-f@lex.la> <44f163ed-8362-4aad-99c9-f8709dfbed76@lunn.ch> <20260910153757.2822676-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two of the things I said I would do turned out not to be doable as
stated.

> It is fine. I would also add a select or depends on the PHY driver
> Kconfig stanza to link it to the MDIO_AIROHA_EN8811H driver.

Kconfig refuses it:

  symbol AIR_EN8811H_PHY is implied by MDIO_AIROHA_EN8811H
  symbol MDIO_AIROHA_EN8811H is implied by AIR_EN8811H_PHY
  error: recursive dependency detected!

The MDIO stanza already carries imply AIR_EN8811H_PHY, and that is the
direction worth having, since the MCU driver on its own drives nothing.
A select from the PHY side would be wrong anyway: a board that
describes the chip as a plain PHY has no use for the MCU driver. It
stays as it is unless you want the two swapped.

> The location is fine. MAINTAINERS need to list it. What you might want
> to do is list it twice, once in the PHY driver MAINTAINERS record, and
> again in the MDIO driver section.

There is no PHY driver record to put it in. Neither air_en8811h.c nor
the shared air_phy_lib.c is claimed by any entry, so the header sits in
the MDIO record alone. I can add a record covering both files, but that
puts my name on code I did not write. Tell me which you would rather
see.

The address check is in and the child bus now refuses anything that is
not the address the core answers, with the node in the message:

  ethernet-phy@e: address 14 is not answered here, only 13
