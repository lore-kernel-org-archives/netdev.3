Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47D317169;
	Wed,  4 Mar 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620912; cv=none; b=OzrYSjbYZh5327N11IyZHU1dqgRJH2FMZKDJ/Umh5q8cD7wXbL9DCkzq887Gc4lddsweVIUI2705J/UrvvrXtjGgiIEl0CdcFr7YPAe5tVzwq5JpbPbzBHQ5VuW1KSalIedbZoJor3eQkpYHHqAPvNgMNlOI9eOHANKxnIvQusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620912; c=relaxed/simple;
	bh=vBzpkkTVbLKqzEH4qdFsf+sbCUXlAQ9XgD2FcdA+1qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD6NBpLvfA00x2RHkCd2oYqreNwdDyZJH+fr0GTA8envfg5LRY/HaIDeLnsne6jpUQx0nLHaab/YkqnBFgpJpd8gJXN+g+eU1lF6h0JKzyoO/ipJ3zklFVgtEF5fklYjcp3XoCx3NW+A4SM0x22+hw0mX9QjS4WEjVwxCLmSgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vimux.org; spf=none smtp.mailfrom=vimux.org; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vimux.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vimux.org
X-QQ-mid: zesmtpsz4t1772620898teb1f7222
X-QQ-Originating-IP: H5fycD9ZnGNZKs9XZlO/zEXviELiZsMYot81Q8K4xxo=
Received: from localhost.localdomain ( [113.120.117.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Mar 2026 18:41:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 108753647102746725
EX-QQ-RecipientCnt: 8
From: Jialu Xu <xujialu@vimux.org>
To: linusw@kernel.org
Cc: brgl@kernel.org,
	kees@kernel.org,
	krzk@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xujialu@vimux.org
Subject: Re: [PATCH 2/3] nfc: nfcmrvl: convert to gpio descriptors
Date: Wed,  4 Mar 2026 18:34:41 +0800
Message-ID: <A8F8872018D582C3+20260304104125.523019-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAD++jLmWt0Z=Bb1z0BSwMY-1KDzF=HXR6zudWCzouWDQqdotVw@mail.gmail.com>
References: <CAD++jLmWt0Z=Bb1z0BSwMY-1KDzF=HXR6zudWCzouWDQqdotVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:vimux.org:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N83uKqxezP3+Bg7nmhgVB2W3HsqAY6GkEg17159Dax7XnE1tNW8OF5Lv
	w0teitNXZeW+ZJvft9SyYsHAAVXHrTqaKzwI6f+xWF1mgplOf5+t5dfVnvxMlbQqSJjpc0K
	J2EQS6IkyNr0Y+DMZm1aUFFHw7ZWNNI3iESx4nLpy6cI+yLYDKW7vP3wk7SWGnQePOvIIif
	d7sJS9myBAuY0QdUKv3g39ND6lKI1EnjJ4TG9K5KU08Zl3pzBZwizVZqBynuixb0rcsHKqQ
	a1bFEMjy+DpQxV8zjMFQ9iI+X9LgCb6kXv2BNw1MtLiSVvXo5nuorayEQfjwA6gBa404yLB
	wonjSJiSc0251CQXfoYktbORT7Eh563qQWDr8SRfc/cgrcRQO1iOoSfk8Wy8Ce7grnrJcZM
	enttdCC5sIuby4l2GIstEnnsUu/ROjZMzPhS1K59Q1EGjW94c3MNQz0okrZ9W1TbnW5M0/M
	H3Kpf9sTh0GfeFTTLmFjU4RDNjKblld2QvNVQNuY0HrBNLXIY3GsTRpCuNVD04Nnv1jJfMv
	7JPNUZhZYdn6O6ALIrbS1AhzKJkLz6TG0CV5s7dbk1GW3PhlmAN8g2TqgB/yALEm/PRij+b
	U1MMfXfmckCLLy1j4qqqt6XgWcFzwcZdPd2ZeOoZdkln4UtoTly39frHguQDM6LkVp+OB9E
	xDyFDAdKAKvkHAceWS1dt+Ts3GPUW+QJAuf8grvmo3Xy+3mX0PXe/d2Os2P0Z9exx+JKX0F
	GRm9bSDbofLq1cjH5GTUfSF4xKijtnWdniTRyihvpvrai0HmusQvQ6dD0xA9eiqIaJQ/A61
	DmGEFtNcDgZ7j6m1xEjYksRji13BZ9l9O5/CpBbO9PdwbImEiL3laZRp+67Xw1Sb60TqOWA
	dJQB641Lk5Lthp0lfG96KAZfZhsBkG46lRCvKb6f2ldGyzkEjzxH9lwYcDemi0WxHHy8Wzy
	L8ul14c1XYzWeVL8cdAg+o22gf403P5FLx42tMPr842Fu9xsVWJOxh5kHpc5wn3/WoRE=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

>> +               priv->config.reset_gpio =
>> +                       devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>(...)
>> -       reset_n_io = of_get_named_gpio(node, "reset-n-io", 0);
>
>This isn't gonna work, sadly. The property is named  "reset-n-io"
>in the device tree, not "reset-gpios".
>
>To handle this, add code to drivers/gpio/gpiolib-of.c in the
>of_find_gpio_rename() function to make it pretend this
>custom property is handled as "reset-gpios".

I see, thanks for pointing that out!

Seem that, the rename quirk for "reset-n-io" -> "reset" is already
present in gpiolib-of.c, added by commit 9c2cc7171e08 ("gpiolib:
of: add a quirk for reset line for Marvell NFC controller").

Best regards,
Jialu Xu

