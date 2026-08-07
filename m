Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77F4749C7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114801; cv=pass; b=C5f5K1DvuHJddfmdXJFEOkK861VE02H57+gCnmXNG0CjuNnMNuPS4S8kR0NpO9znTl3tbz8lPWPohY7t6ONwCmNO1ESU266ZLyBlA8VVXH11f5V1NB+519YFOnfOD5ENzez3go1Ckg3YuUWkzjfcIx2p/pmjPHCWu9P+mP9Ahb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114801; c=relaxed/simple;
	bh=gV20Qq1q8KHAEqMNSgw5mTDYx8Xl3nfNz4w7UDZshT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3YSGbsmcpQzISkUrASYXhUKBLTCnYapL64uvi5a3R6jJoETl5iikzlfnOkF2BzrNRURwzbxCOo4r4ZXLz2Q0EhXpkgEZQ+yPNzZhLwa+RWVhdGn8hThg4z1ZqVpiYaZcvIZ5+8EJ4hVTQ1+z7HR8686RY0QHa5MyFSXtxAM0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyl+qiOJ; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyl+qiOJ"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-977168e4f3dso2207313241.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786114799; cv=none;
        d=google.com; s=arc-20260327;
        b=SYNVKnlbysCt/vaSHEr0HBqdbwglKLEWVzebgPksi9yhAcE5xP5VPc7WgxK4nk8iuM
         ZpsuDZIKjd0ylX54pOe43v5CAMq9M9Z+5kVOvrKJqaYaCnmqBJa4D7BJXl44+DGdy3sS
         ADTBg5hDmAfColUdVuC9IQnw1EWZF4L1nzrHZfvjyTrEyFhyzpZL7ZGcTbCqGS0whEDv
         97yzWPm37jpNeIrFSByYHXqlA+KH6pl1jXR4ygG+mW9wMO3zRlxODbIVKjk+DRAcJ1dE
         WU+hE3VEQZBmBKq17SlsL4ac/5UvLWRUfuhGRLkGrpuedmETnw3djQyteQJ2T2YukBMc
         ELaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        fh=PQsvmajA8uisrdQB3axq8AyCue+3aRKy5qeIGURsNuk=;
        b=esTFYb40PIi7OcDkJxhdc8XE0foVdTRHw79MWz3UVAx1oAUnSFvFWPlgQRZhrzZlmZ
         6T3BXeYS9mT7++DSal1wygjLWT4tcEEHLAJtx4oGCncbFx87DG22zfVDIWYh1R0ws+9k
         eQLijVZvUD0yQ8JOQIetnWPP76UgL4A7U343Z3xF5L57dtcUIxbnTCmKNdPC+Xlyw7rv
         4brV1tqo6RLMmXC3vwyYuCsXN9JSpAZUXGEH82AcJn8J0OcFJ3gYDCbZnxAZ6a7v9t8H
         pJoFAPoY95I9LicpBj5o/CBT2nC6cJ1twPzyvJh9JFfCcB7xWmmMvDDqFULnYFxOi8w6
         25sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786114799; x=1786719599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        b=Gyl+qiOJiAmjPzSOy+yAUbgHE7C2l5ryrcwZj7SEstdeZ+RQ/gj0b3pqLcoW8xI+G2
         w2S7/9zA5bbP10Ap0l2Y67e5QA9K44vSAFVIWbKWgO6Z/6LORJD2qArzV6qC4vK4fVhi
         eMxU0mH8NslkObuipwS/rQBTeJrw5of9PMksU9uX9cTRAZW3bLaQY6gq3kblSvGOAJvT
         3U2CmeCH60eiIbrMmDDH3T+kowUcOpAd++FiuYPTcTvC8T+++pRDc2WTzkLjNMsD0y8b
         mryaobBDYudLE61t/mF0Znw65XqqXKH37ghcuoyZbB9lu0pIgHgMsV332cNNIFOP1TRa
         E9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114799; x=1786719599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        b=dPpLg77wktS76UyvKzpBxvA2lyVF5q4HxKN1Ye/YGhbgGqY8AzYwywxJsRJVRDnQY5
         uv2VaduV2hP0bHghJISTLtcCRZ4t0ji4kjSs6GtD/L/920CHcyv+idxpkRj8eTHaw2On
         VYMbJFPMWcrTeSwxHP5up03EBJEotunQFFeFZTsR9yUvwcDlQBO0lhCiTS+8BLV3nfDU
         VL4qWUGgmU5Mm+mGXtOtBAsgF8+H1igNC5zvQRafWZO/u0PFyAi481YXIArfcgU5Lo0F
         8wnjWnDEP72VZy6aln/iSA7hdoyKOUgtKrjZNdhAggg/X245XTqV9AMnJYuDu4+YkRn+
         zcow==
X-Forwarded-Encrypted: i=1; AHgh+RpaZeErKpMW79c8D6DcaA/TyfZ+hqjemD9uj79i03/+Ex8LnxYapT2l4U2RwEBbFZWjRQElZDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTva5ZaAa+++mFbSMsCG1RhauhNqgQVWXfiN0W0L70zyWMIe7Z
	NSRid9nL4cHqIOuhwcm47kreCYppEnCml7hRHB1lXG257Qi5v3w0EbzotdyxWWWQTudA8Ck3esa
	Cl/SCrGWIPPUbg1Btx3aYhCogzrdH774=
X-Gm-Gg: AR+sD13LZ2tFSeIjIgwqVg97zm7Y5BkLGePVh7oyAzYohmJZFdacxkVYoMdd24AKOYi
	HzlYnXDw1kzT1a/zTc07ifw144ECrjDXl+mdD7s6dq+PwvEcOcWc3ZO2fPeNWMDfgeE7upQG8D9
	ZBIgf947r0bfgkWZZNd3flWEYUYxlXb64uW9dgj1A9ynZrkexmwkeO72H7m7S7WpXML49o6dOAm
	TpT6ZExahTc8CTFH4h4bJ7qeWqZ+1YUYMzW42CM7tEIP7lm3JKoQ66XQCdzgXIUgIYBS7L6g0vy
	4hYUYHl5PQNgq0Bo/lqVLISVpMPmwPQdDVf5Vz3qHA7IvC+dlzSWCR7ahv21rCyUkwprAVkntP8
	wihIGFB1q7motu/GO7yIqJHwpozl6D5i4VaUM2dpN04yOeldFK2xZ+vGRmZIdBHKXWenrX/j5QZ
	+35XJToRyeo6TwtTZyMsnRRpDlQlI7+lxGA00q
X-Received: by 2002:a05:6102:54ac:b0:738:bf0f:d0c6 with SMTP id
 ada2fe7eead31-760e3b9ab74mr7413161137.0.1786114798682; Fri, 07 Aug 2026
 07:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com> <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
In-Reply-To: <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 08:59:47 -0600
X-Gm-Features: AUfX_mzMI4rGrSWJxil0rkCdGHQcdQSp5kYsnGxukt-NVGzxhhYkib-rvufG5PE
Message-ID: <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> > MDIO buses enumerate firmware children only when the bus is registered.=
 A
> > later devicetree overlay or status transition is ignored, unlike on I2C=
 and
> > SPI buses. Supporting live reconfiguration also means that population a=
nd
> > removal can race address scanning, PHY attachment and bus teardown.
>
> Please make the bootloader work around the issues, and drop this
> patchset.

This is just fixing OF_DYNAMIC for mdio now, it's no longer used
by the AC200/AC300 PHY patches anymore.

>
>         Andrew
