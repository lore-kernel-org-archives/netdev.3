Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE83AE704
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792878; cv=pass; b=heHIPS8bKMhf7bnrAzd9pfUi0vmbEJJ1xfoA217PE8WFK4VAjmvAVzqqEWGPQtAOkm592IirbNFfRSedHr5wWjgWbf95HCrCZxRqR9ymgUJwgDVHI7NFT3bn9VbCjJEOXuUXk49OqgEiF+RGyxZUlu+7CEN6kNYMyegpVaHCMfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792878; c=relaxed/simple;
	bh=jrCpdiSBc0sqoht3jRVlLKndiJ6qMGmFxu9cVzHBY9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xahb5EGx+/ULXGx6M6fCe93bJ51kp4vCW2K5scNnQjHdrG8e5irtC5jW5LDBKZ2mbKcRQuxlLm4YRvwHqb8kKd80K22M0MHcJ8KYMeoRhnbJsdlbYAr7IQ/+Pzz6/8Y4vrXsqZ0DrJHbAChMLhpNPYjbyLwEliYq8ZPKw3Kd860=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWOsOIoA; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWOsOIoA"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-977fca41f52so788652241.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785792876; cv=none;
        d=google.com; s=arc-20260327;
        b=SzX3FHhZypvhLpE2Y9l3W7rcJipu94TjVgSGeuYEWiJFJqAj49dso7M/lddquNJfFj
         lXODllMPCUE5+vth8GoNc4XjXUdkogJUJW+FQJhOV0x4mzQNNDMqsIPP3eGT6e6wIkT2
         MWCtrQKybMfZ5JGQsdJGAyQ+wdCyjEUVeE3r0pNM4lWyTKRvK+ivCIDLcxSqrd2Gk8cL
         4AB3XqEnYjgdRmmTZGjkafqVwWExcLRBTAPsN5bWe4HEFpXiPb/WczXSxQPAt7ZZeooj
         OJK1L16QmcBkmr7Q5zyKTnhNBmBkWWgRu8SMBpOf7z8ZnCZVPKPDgEx0Eon9n5Hl84Is
         uaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jrCpdiSBc0sqoht3jRVlLKndiJ6qMGmFxu9cVzHBY9o=;
        fh=ASBiC3k/4gbVL+GnmGyFbWDntg0zMTxf0YW3uiyRsUA=;
        b=ix1TDfH/kFR6ZpVwRVksUOj+8uaQ0CD2iXhsRk2l8Q6nYe4wfnkPkJxYc/CspLcdmQ
         eRH9d24pdZpSfnvZaf59kmt97KGmB+aDyQjRRPtoZzIIjExS9JDUl2ACe4u6vIExcncp
         9y2/jRr95Hg2+t/UmJaRs3qxHUh0xyLytai9yGpo7jQ0Tof9n42o8CfRU2gSMcnrFYUQ
         0R7B0ZJ66BqvPc+rBoLdAUgyITu7RJTcy/jxKgz/5/8yof+s/5vPNkOj9Q1hphjXTTiv
         XBRaKku0AKPaD4cX4viYTAHVlXrYWVLt9TdW6kIyiwKHzJL5w12Ac2iuBhxNdd81cmlt
         xQ4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785792876; x=1786397676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jrCpdiSBc0sqoht3jRVlLKndiJ6qMGmFxu9cVzHBY9o=;
        b=BWOsOIoASMgYCdDgFcYnvVABfPMvwgFp8bu0TIMQ0Mhg49lbJY9lzaxbT52Y/1xFTr
         Gj9U8CjYBK71vzbzLP+XGhY/uhAKdaPwZS9uPS3Bofpye1Xaleb7fkXRmH8tBUOWm9kU
         CFo3/00vUT/bhKdoPFgysqdwOBzxYLY9cdmZKhbq4cChjaLusFW/Z10d6vL4kJkZcqIY
         YWhUx0j6yZn2wyILRu5gk8YT3HA8h+D46oW5ACgVVycFeZdmwYwG1kvTbBDJdsg5uOH+
         4foB06yuhh98QoZ7elTui0FIvFDXP+qTV3CwPQOEEFerxGCLz9rthm8rbwbErxha1Ya+
         EKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785792876; x=1786397676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrCpdiSBc0sqoht3jRVlLKndiJ6qMGmFxu9cVzHBY9o=;
        b=kr4VPkiYyQbQSyAMxGgUxVpq68Aot0eivHoiW1JDVXC2HfPIR1G1zPzKQHtdVxF7Oy
         qAm+y8GwxiEInj0clVxTrSqMPEPpJjoo08arEgHmSkqg/ABLxu9M1BNQFocStI4RXfxE
         vOTXvRiU5bKYu8bID9z89O/GtyIsEIKuMbDriMF6VfSPVfkbW3J55/WOUZdd1tyWxkrX
         pZl97xLVnmNRNySmZxYSSWRbZ2Ewyuo4IweJO+0QH1fgn9wvUHBbjV5s1CQDmwUys3tK
         c7biJNvNKUzaocaG+szZQDCPxERE20T1zWsbVSTBX2+fcmO1rtT7nhYMFYgDMeUor/S5
         u7uw==
X-Forwarded-Encrypted: i=1; AHgh+RoDetrHjtsA8GGdii1KjY+DVugFrOvGwyNk3OFWaBkeLLkIRDiblkyX5UiaQYyXLk/cdPlEQ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ypOLgtPG3qS5a2yyyiXFUw1qnPNMDoIgc7Eku6hPD2eXGfwg
	3vOuE6y8s9C8xIrodJbPMu3bLWF69ssoyVv7jsGYEG0j1nWNO9/E1GVFavBYovTegDj0s+/B+WW
	lcrsS1R7AFOg1XQT8324H05X7J/Io514=
X-Gm-Gg: AR+sD10j49Hxl+MVrczwhoIBny9M3lTUMFE6313WoGb06AuozoICN2klSSnH4OARDLP
	LxaOrrSueEfrYul3IuTkhmnceSJmcYj46Ix7WizIl4BaeKa0A9L4Dvik6LKO1Ye0xmezjLaZ27L
	rmnKP3ZNblmH1Bj5F4tc8EZhYXNPDK85CYOvZuPzHAtC0XHLIU/nTaECYr7FTNNVV9eNEb78dN6
	i8uMfxc1Zb6OBkKLuoGhJQqKpR1mVANISbklqfYrix2AC8rATyZP0XJCAJGAHyllXIykvWyMHVS
	l7W8jdi2W1345Bh8OHLd3nZwYEke2t2cUI6yU5BFWSmuv9egbWIY81VDr/Ssr7+XPzTY02ghvWV
	DDzXyp4Tstx4ydHau4o9QNvkBhxvkA/L8V4O1QRLV0KRGfqFKemcBKwqQXyLxqahh+M1Nky5U+l
	IAtI1x3jD9aO3vLdJXM+COwFoPJrk9hxnJfu7/qT733od/hxA=
X-Received: by 2002:a05:6102:c08:b0:74c:7fd8:73eb with SMTP id
 ada2fe7eead31-75b2196451emr9291357137.1.1785792875669; Mon, 03 Aug 2026
 14:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com>
 <f2cc3c90-060f-40c1-a55e-e2ed91e65487@kernel.org> <CADvTj4q7HnOYJZE-M070-1npEdne__Ct5D9FeUNVVXa8Bsm7qQ@mail.gmail.com>
 <e198e8fa-6c5e-4c8d-a4de-d8bb25aab0bd@kernel.org>
In-Reply-To: <e198e8fa-6c5e-4c8d-a4de-d8bb25aab0bd@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 15:34:23 -0600
X-Gm-Features: AUfX_mz0nFlKIv_Mdqu5KdrEqoS_kIvG6t--sSCBfp69bBMk1YT6VypHPp03QP4
Message-ID: <CADvTj4rjXGgF2d9Xm6TmeS2LwaM+O2wFFH=rGLA32y+aMk2KOg@mail.gmail.com>
Subject: Re: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 2:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/08/2026 09:54, James Hilliard wrote:
> > On Mon, Aug 3, 2026 at 1:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On 03/08/2026 07:14, James Hilliard wrote:
> >>> The AC200 is an I2C-controlled mixed-signal companion IC containing
> >>> audio, video, RTC and Fast Ethernet PHY functions.
> >>
> >> This fails when applied, because you did not explain the
> >> dependencies/merging of this patchset.
> >>
> >> This is THE MOST important information of cover letter. The first thin=
g
> >> to explain.
> >
> > I did mention in the cover letter that the pwm series is a dependency:
> > https://lore.kernel.org/all/20260703152215.192859-1-richard.genoud@boot=
lin.com/
>
> Apply this patch and test.
>

How were you applying the series?

I noticed sashiko was also failing to apply the series:
https://sashiko.dev/#/patchset/20260802-submit-acx00-of-dynamic-v1-v1-0-0a5=
3cd9e21cc%40gmail.com

But that appeared to be due to sashiko missing dependency resolution,
I went ahead and created a PR that should hopefully fix that:
https://github.com/sashiko-dev/sashiko/pull/389
