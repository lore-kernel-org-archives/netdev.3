Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B629BDB5
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695157; cv=none; b=m4X//rvqALtDKT+aWVsjsZ/PC6chj9ls2KIdvKa6rpA8mFKWavWi58E2ozoIAaDTL7YH2c/dSzQOX1MNKHpmLP0pCG+35CFF7mWZzDWbTOkTuaniCy82bcWLXQpiiCW/Frx6A8m1JbIKxW4XpV38nEuz+TYC8zviuiCzm9EF+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695157; c=relaxed/simple;
	bh=miFaafVCXNwSq+nl8Kau8j0yfw0gqzbw8XlRunQpNTg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WhJYv+tMeUCWmI3nOI+HjqOEMSluR+WsJ88Jvag46hFsa6fUcO3w1FmpcuQdP+cool73i7uFspaLJZGq5RZETIU+wEMi2BQPsjxNtdm5I8Ng2+/uNDHEKl+GPrTakRxdOx8QD6rzjkT4CtWWcu8r/yJ8IiTuLwPj1g2BhHYcmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/qVa73x; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/qVa73x"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc80544c74so7550815ad.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785695155; x=1786299955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F7s3GZYSnT0cjOvsmd+6nT8896EOTxni+8aCua2o/oc=;
        b=N/qVa73xU8RNQ3mmC9UYKsojEB88PfmggNYXMEHeaxME238RDYfVWkUEk97kfb+RYU
         84U04adTYm2THkZRZk9biZR9I6AXLfjfok48qNMD2f1Ob522Wvly4t6/nsUpnDElQOv3
         qhIGqw8YOm7wDp4enivkP3rVXSeGLxOZEkhqmMxgxDDUX6PtOcdpFTTsdftTlD9wyxiw
         n7UkbGd4TUi4c9qozeCWEyl7Y4LdIZe+iIR0D5HZgXu0mEEpOsVAlF+5R1L9tJdRENd5
         J4R31vcmPCee7hJw5XME4zEorEvpen/KtZzNLjCFJ5XXeekLocv2bJtLHJsg1YLHe+FD
         5KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785695155; x=1786299955;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7s3GZYSnT0cjOvsmd+6nT8896EOTxni+8aCua2o/oc=;
        b=Q2Ol2HoRzkKOtpcCxEkMp+LXnSzQvMUqwOfkTnvvKWNsCxJeuwNnY8UttjL5Zp71QV
         01JsSRWcB9Wd639j5xBCwo/dhxZ+kvoeZKteGrKC3/m2RiznAH7d5eqL4S1ZE7uIH9oo
         o+EuOSbQbInvJxg6itxq9L1suv5H7pJOXVTa6W2aiN9tkXye3N8FAkYbq0FwahK+ZkLi
         dijwEtzj61HDZZNq7WRANuYxIC4vZ1IOs0WCHV1v9dt8Z42dRqF5dhg9n+cYJ7HXCb8v
         cggvN1Zx8YV8Yz9Z4InTaPhHdh4NAmW58zJbtZQTvX/1vbz6lMEpgs9gAr7yDvguhUum
         ajVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0mF8efmk+dO/lKD8gqTnM9oVR8ZZ+OD5Ee+jK37jBxXzWZ1ijCf47lipWMfr+YTLJkKlDDGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8BMnRwcnprBJqv5HPZXtdNNUG10FAVZ2g+Nm7tj3IBIeDjVb
	5WYQvvfq/aK0ybUlvhf99Ml9qorfFPOYD19BAUVCg6VG1HnkP7bTI3CB
X-Gm-Gg: AR+sD13MJ8aB9NoUkNQbj6usWCJ2O2bux0UwS77XopDeugjdGQad7obkEyPeYW3Wdm3
	+U8X/Ap6GaW5ua6Mks5HByivYh6o0o33I7DZ9sbeU8woFOKbUQZudcj3WJigXxx2O0xT/EGTIHX
	sSkB6LjU07bf6w/oNpMUomRqBph9lezB9y3BcAy/jWRLCOgVfl+HyYqWWVeIPlfqSdJs9UBqywf
	WjD1DIAxCpPUC27wV4W+3RwNkzTCAH8HTAVqxNQ8UIF8RbeK5ah1fblSk53Pj6BPi4/Rzqp9DaH
	rU2/zjkqH+aYhYWwGfncD5HC54LwiHgduzQfUKgMGDXXWiwvA7uxAaL4cIaQiaMm3SdoRbUWvK5
	EsQ4mNn5uec6FrKmqT1OPwQVlgE8KVjjyNg5XbG+cvfaLAbKX2888/Sf78/CLpB8sFa/S65YIv4
	9eS0rTL7tWhEv+4d9BFdQCt9tAhl83w/mJEc/ZqIO1ZlddrqI3JunC1DDalvuB0uRB
X-Received: by 2002:a17:903:b4b:b0:2cc:dacc:fe27 with SMTP id d9443c01a7336-2d0522984dbmr69929465ad.30.1785695155310;
        Sun, 02 Aug 2026 11:25:55 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:5a0:1000:10:233::14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb7b7sm27443245ad.39.2026.08.02.11.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 11:25:54 -0700 (PDT)
Date: Mon, 03 Aug 2026 02:25:45 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_06/10=5D_net=3A_pcs=3A_xpcs=3A_add_?=
 =?US-ASCII?Q?ANRESTART_support_for_SGMII_link_recovery?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2886b24e-1c3d-48f7-8b22-9620fa0404f7@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-8-coiaprant@gmail.com> <cfddb747-11d0-476d-8402-e0886cca582e@lunn.ch> <CALj3r0i1TCTgvm8FrJAJqmZgoJp61NCxc_xmVYaDFd-gh4H=7w@mail.gmail.com> <2886b24e-1c3d-48f7-8b22-9620fa0404f7@lunn.ch>
Message-ID: <2E676CD9-82F3-404A-B24D-27679042783B@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 2, 2026 10:30:52 PM GMT+08:00, Andrew Lunn <andrew@lunn=2Ech> wro=
te:
>On Sun, Aug 02, 2026 at 11:11:40AM +0800, Coia Prant wrote:
>> Hi Andrew,
>>=20
>> Thanks for the careful review=2E
>>=20
>> > This probably needs more wide spread testing=2E I would be afraid tha=
t
>> > if you kick off an AN cycle, you loose the link until it completes?
>> > You would of noticed that on your hardware, but other hardware
>> > obviously behaves differently=2E=2E=2E
>>=20
>> The trigger condition is: link is down AND an_complete is set=2E
>
>Ah, i missed the "link is down" check=2E That makes it safer=2E
>
>I still find it interesting that this devices is different=2E Has the
>silicon vendor done the integration of the licensed IP wrong?
>
>> Regarding testing:
>> - Jiawen Wu has tested this on Wangxun NICs and reported no regression
>>   (Tested-by tag included in the patch)=2E
>
>Probably Maxime will test on the platform he has, but i don't know if
>any use the XPCS=2E
>
>	Andrew

Hi Andrew,

Thanks for the follow-up=2E

Honestly, I'm not sure why the RK3568 XPCS behaves this way=2E I don't hav=
e
other DW XPCS hardware to compare against, so I can't say whether this is
a silicon integration quirk or something else=2E

What I can confirm is that on RK3568, the PCS does not restart AN
automatically when the link drops and comes back=2E Without this ANRESTART
change, the link stays dead forever=2E

I agree that wider testing is needed=2E If Maxime or anyone else finds a
regression on other hardware, we can revisit and condition it with a
platform-specific flag=2E For now, the change is limited to the SGMII
recovery path with a safe condition (link down + an_complete), so the
risk should be minimal=2E

Thanks,
Coia
