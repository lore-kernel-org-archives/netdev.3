Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE0547072
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261779; cv=pass; b=LYO3JEd0s47S78mmo8VB3rqVKX/KR6BkBAlY7gbNLGXGD5YWf/AY9PPx3mx5yBCM8eMRwx9LguzGL8hTo+0Z01eHKrZupwvAFY+oPvGRtXn20PHQxCtNuEjfB7ETLx9aDSGf4Qli4b9ChQAzkPCT6QzuFJ4gZz3MVKeibESrhls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261779; c=relaxed/simple;
	bh=YLXZVAzabw0uTjvEyX2I+3A9f8zSZu72xxMQhsmY0oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVZwJggwmT2VcEEGED2Rg0Hn7lzNFzv5UsLbz1LpIPAAISfcBGeDgmHPX0Kmnz/8jtz354XAppqp4gylG/5NubLGoNSaCb6ZAmDw+sFgKWLmV7vsF+URk+7B8xmu+CDP7jafmj2CsxEgu4U0Eo7niLMUXa6joml9ybmylqXmuVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn74sYg4; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn74sYg4"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1239031137.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261777; cv=none;
        d=google.com; s=arc-20260327;
        b=YoepXWmzhau3ZYoHXdqeyatLkJ4yXVlUBgWO7Jyip2MP3Wc10oWctooL0z/EitG1qN
         EN9BA+ZAsjEapynvHmpMyq6zz26PBSthB51BBgDS8+/WKFdvzMT6TvNm5YX9GMirmjXc
         Cgo6s1qfc3ikvI77N3YeFhSBwmIELTp5hgyGjW6f/qKpD6oB11T4V2+s3t7UPLH5os5b
         cXCtl+bNGMzsChjKzzeaPhk9S4YSfPQBa5RZ+zEZrTuvkE4DOl+bx5h9pyt7UmEo+Qzw
         mf6H9iUjsV6zYU1Ui1sIQtUTwapSBL1a7Dc4SQFPRUrpQSOAPi7vjoQNBWjEMoE98uHJ
         S+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJ1hzyxGEgvXH/ZFAKmTf5EgU5zVKhz644TJMr10DOM=;
        fh=zVH9TAG57MCf8zLQ1kI1DTndxnEpoTOvxdw/HY59CTo=;
        b=EV+BPboWox/R58BjPDRSxkTWItbFvHyHrVsWqWcjBb22pHZ8AJsZnvHD9dQrED09FX
         XlTNYegk+Ge8NRyg5Jy3NJFGAKQYpRO9GqRixARz0KeEyD8a3RTq66gnDO4GR8h7bIVm
         tlxEIsVoKPY7sHvz7MCYguXIoTqRbsVYOte5bmOz/+RMroRy5lBZD33nRvMlhI7kp3lm
         MNp+Y36+rnbxueUpYxEQJo6dI2KdZhvuattC49OmUfm1B0tjTuWNE4u/YZcW8G5p5dfU
         +WtIik0KBbYbe/txOVordr1xGJnnp4p/qNaXPHHdAiWnBRZbp5qfverJVXd6S59by3Sb
         h8tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261777; x=1791866577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJ1hzyxGEgvXH/ZFAKmTf5EgU5zVKhz644TJMr10DOM=;
        b=Kn74sYg4RbIZxFIr1be683QNaE6gR+31HQb86NKkIgTDrVfCAEUXDCTh/b+SAAPArF
         wKRTD5N5vTQPSkj6vb87duypE4IOCRzMdUpdh901U2/ogvehDZBs4U5WCrqzerWBC+i1
         zoqAn7FEaJ2S11y66nhnQ8fauDttMrx7hGmwQ5SYKTnOF1EUP+WizKXbnGnpLuCGKX/2
         QrtUogRAEHAhpeuwXBwkEfnvqYdRgT4G5oCLDDei7Sw5iAeXg60E4KiLVeFLa64JQZA9
         2+3SdNzReszKR8MjhBXZ3nKSa5HJgD0mvWRgAITs0Sh5wGRM6NZ6mhWqsZdx6gXn/Tk+
         5mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261777; x=1791866577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJ1hzyxGEgvXH/ZFAKmTf5EgU5zVKhz644TJMr10DOM=;
        b=nLJvS2o7CDiGbYtwEY514JdbuBhawrklxH1o9rLt8926SXVEhPDeYV4NY4JGqLvNjq
         7QWPsGMWJqOxrTNB3AF23kNu8zCruDq3cU6qHCNY1G+WUo1/j31lx0061cJs+VkYvsYE
         8XKacXYkNRfwAA0/SXVqEiAYdlas1/vfAIerjQ5sPdifuYI3V/cs/O2lINTX17p31AGF
         JiNwI1rLWLw8Ovad68uwLrliBc+IMDbTE7UCqWibx/OQDZnzE+HwSG9DsLrW/GVj1yGP
         BNWGtJXtvrZNe6BRY3QDtWcpn0Qg1XTRFZxTtVOYbrLnFJKudDDQSWCCr0j5Rt1hvVZp
         qqeg==
X-Gm-Message-State: AFq9FYKI1IAfbTHdmpPzZNwXKNkZv2ky6JShOim97DwD2pU8/7f8T1Mo
	6y2R3VuwnI9qMgi9Ambuorthez8FNxr301Gwmze4j6RZWzt3aR+Qum7PiW+mQl7PjTIv/8fnQA4
	xez5zD8Sd/CCeDVRrOMtpcUcpRKv2cys=
X-Gm-Gg: AYBFou0zuF+MZgXw/nVntEx+CzOJxgHfnSBsbdTfsDqJUvyVsx5Q/WMmUDSM1F0iaZQ
	3BVFY0k/17yKk/pDxoHkvu0oBaAN6DlnbbQhzK7F/AL95kujK+Yxl1R8smLA1BNWW9lcmQy0L1F
	mNJQMj//qBGrUpbXSRUaPAtEnPhnYg8WFKnMn8dsOpZn2bdg6p6wlmRUjVJ/GRJNekswvUytxf1
	c2XR1JWHa3M1gHSS3joBfmjBsZmxo5i/xdcRJIUE27nwRTBs4M+MwT2lp3PcNu+cT2ltK1qUeQy
	VsrdzQ5ZRouVnVKrgjeAcU5IW+FkX+QjXmNnXfo5JxPMwssRfEzQ/SegK9KCMvTXefBTHnv1Mg9
	swgv/TOHK3uy2L+mnlzFL0yq8ffNGLP0LbdOeQT/rN9Mg1oW3wT+Jq9olGuyoRp7T1RyhaZMknC
	CfMnMKOFRPwvhsw7G/EjMEPt+ztm8hsMa3Sqn0vP5IwAy7
X-Received: by 2002:a05:6102:3713:b0:7c3:6caf:bdc6 with SMTP id
 ada2fe7eead31-7c36cafc094mr1944761137.21.1791261776819; Mon, 05 Oct 2026
 21:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
 <179122764255.1402591.11842213570415395688@kernel.org>
In-Reply-To: <179122764255.1402591.11842213570415395688@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:42:45 -0600
X-Gm-Features: AclHuK_Y9haDQlUkQ1-OLiXS69zhrfwKJou28sxTeDUaUR8gJdKKHU9izxO_gLA
Message-ID: <CADvTj4qHRjm2xSNcO0qX_6y2mfT0RJPbt-yGnYYnXstxUZaKJQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:14=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Controlled failed-resume/down-up recovery was exercised on Allwinner
H616 hardware with sun8i EMAC1 and an AC300 PHY. This was
fault-injected, not a spontaneous failure.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
