Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B15282F21;
	Wed, 23 Sep 2026 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192162; cv=none; b=B1vNZ3B9NMhlzlC3dFJF2d6X7QrTUdAlJmILLbZNpitr46YwlGqpPdiuNSzDJDVJtYckOUQAV8gYL216c1vmqJ3ipI3chu/hCTMF18EVXkAEbrRBYWaL6TKHvBR8g2gtqb4RJlmVsHsVffqPXHrZuM4bd3xQ09yosnhDyZ1x6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192162; c=relaxed/simple;
	bh=2LDuMRNED5wdqW1AY6gA1vtr2Aph4RkKWDgvfunq4v4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPT9Kl+bkotIE5gndqX1jxccWEBFRgx9pux3ejM6QdQdNuk574YletekzyV6PaTzBZgLZ1b2Y6zO3tHi+ZtY+8HDwbhYaZqR8J6oJWPfQo4PnSM/3Hd8GGlTWE8VHF9vau9Uc/SfK6AIFWj+TnzJ0a7GnnfmP0Mb4+zDONOuthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eHDVl/cG; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eHDVl/cG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790192149; x=1790451349;
	bh=fhmnpnkcxvujnteMRxUDsHManAcGr3a7xj98F4dZP7s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eHDVl/cGeazikvfpoDbxUc+rLnR8gVrH2V2avAJoEwpE2vOEMXm+DC0aeePJAw274
	 LmIM7/QgX2msJaRbVtlZL36LT2BJgCLthykGULLv3hPD1oGtWYMEiuIbwMSDkaKi08
	 Wb2gNnlembAes730gqoSB1w66jI6V+wPvtOIvbtSxy8VhFdirvK1/J96KmenP0EmVQ
	 ifA26qZAc8kZyfuIPmIJS8u2dFB9g5RO/J4aUHZLGUNgbcGnCUA9JwoamCyIhhOHm1
	 r08MpUAt5IPRP99GkklNJlEBieU4L/eBX7vrXY2uPwcbW8XJgU1NocXv4S27A53KXq
	 ZvDiNzbRhdaFQ==
Date: Wed, 23 Sep 2026 19:35:41 +0000
To: Luca Weiss <luca.weiss@fairphone.com>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
Message-ID: <20260923193525.190747-1-isyourbrainfoss@proton.me>
In-Reply-To: <DLIAEGGE6ON6.TF50P7IWGBZO@fairphone.com>
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me> <DLIAEGGE6ON6.TF50P7IWGBZO@fairphone.com>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: d779e2a9e7d07146ec86f89b93919ed664fa8db4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luca,

On Fri, Sep 18, 2026 at 10:08:20 +0200, Luca Weiss wrote:
> Can you please share how you've been testing these patches?

The cover letter was nfctool, not neard turning polling off and on.

On the 7.2.0-nfc-test+ phone from that letter: nfctool -d nfc0 -1 -p
with a Type 2 tag in the field, repeated, then the same poll with no
tag and Ctrl-C. Powered stayed Yes. I did not cycle neard before
sending v4.

I tried that today on the same phone, neard 0.20, with no tag.
StartPollLoop Initiator, stop, start again: no error. Dual prints
this on every start, including the first:

  nci: nci_start_poll: failed to set listen parameters

That is CORE_SET_CONFIG id 0x54 returning status 0x09. RF_DISCOVER
still returns 0, and stop/start again does the same. Powering the
adapter off and on does not turn it into a timeout. I did not get
"failed to set local general bytes" or
wait_for_completion_interruptible_timeout failed 0.

With a Type 2 on the phone afterwards, nfctool -d nfc0 -1 -p found
tag0. neard StartPollLoop Initiator showed Type 2, UID
53:d9:49:68:b5:00:01, no NDEF.

So I have not reproduced the failure that needs a reboot. If you
still have the dmesg from just before the first "failed 0", that
would show which command was outstanding.

Regards
Kristian

