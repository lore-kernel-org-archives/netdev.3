Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E926412294
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311403; cv=none; b=V+Qvlxxu1GW5Z1U0SsF+xxk1CPYYaIAgie+JYlE906wYh3idX0hNAKRXeb1dUDrUTHUKawA6SSfLZYrBu9BsvVYF7mT2mb1FY0e5TR7XnjfTBsFi2KzVGBdEfP6enGMVeEEHBW4ILVmoxtO2bkIIbS3zvF5OuHhWka0Op/gRE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311403; c=relaxed/simple;
	bh=AvtCVfcWgWbYEWNQXDKLlpw6QKu9G16znCcJfeto8sA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j0Ivwra322SFjAdlry5UlVlVGLSFZaN4HaoX4CG4cYCbhN9b5A+M7kB3dCdCUVGp0x2yHhZNwRg2ei8e4ym+TOZW7jmaLFLrzpf725n5y4xHqLWFk9MGB9hvNUo4e9FR3NAxFEb8mwlMMKuaM0pmUirqkLAZKhjlA2IJ9Zgbr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTRvS+ks; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTRvS+ks"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6682259cae6so550139d50.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311389; x=1785916189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fG9on5R0A/VDaaNskVD5jkrua+u9JPH3I1rvPYIlxxc=;
        b=eTRvS+ksXEX99Kks3dX8Dy7B2A/05Z+NcOh1OVuwr571TpRDc0UzZp4GYJsslebQVc
         W0BDn9MJgsrPy3fiFZiPCS6RhTVOmwiKAz9oI5WYfk1qe4e7AwCdaSRIp7TU5oPr+1lZ
         ojWHw5+vqRs/nLNn+sakwa/e2yzFPhGZt+57Ldv5QgHLGFgJmeVv3dUA8RpoXmHG+p1v
         S/yM0yIeB3KgsSCGhGDaPjjV7JJKoNHhxoglEYsJmQwNWUyUuAo1DkXGVURAZfqvjxur
         0kLwwJ7hftzmkJXbhpXlhgKbICakrh3jXFD79LItX6OdxEvTDTGgrdsbxS6aZA5AadKZ
         C3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311389; x=1785916189;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fG9on5R0A/VDaaNskVD5jkrua+u9JPH3I1rvPYIlxxc=;
        b=pG6kkjRJjAdiUUsoKLjg2FCVwW5iSrCD8Q6hfXrGTceqrNVtSgh6ASmFLI/n0EyGm1
         4XVBvH63a2nWHof5X/x8vEfz4A4SbPaRbQGOn8qXmMSqF3hoXTjRK8/w6dLhQVBM+eD3
         AmSAP1rGT9Uwn7mgtnfUDwKRBtGmKzuorufh8/fjEcFGqzDvxOZMQURwmxQROrLCOv5J
         j2VdXLstnpxFC+OJSjUA3WnCThVisS8Zie8jw5KtS1BGYgnIAA25NzlUl3X2im01FRbn
         fwX9g9spV+azn91czTr5k5WXVPNy8gbtjHFdA2L3G4HJeT1IN8PgmtxL5kZJDTQyyYbT
         J0Pw==
X-Forwarded-Encrypted: i=1; AHgh+RoCTW2CMAs6wBJ4i3Cljolua9Cd6v/RuzCTF4qi/C2zsnEP+jmJJIEY0A6Vnp9pD0byqUWOPf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfF/28tlUbPmgTfT5GgZPjYbPSd3ZMZevRp0mlIwb91r1hyXc
	J1Mjyi+ikUMuePz9NYMEjXIgxmYdpCFZMPq4qWJgIgm+qpZN9doDCzj+
X-Gm-Gg: AR+sD10B0e326ZMAmr6tUtoACZq8SixkUa2wsT5d+ccWwYmeOQBkIBpPD+L6MOj34RJ
	c6XwPGdOMMok1CurJYySyUyX1MW99f5cTrOcwgyr7ybczS+fTjhEeujnzCirEhlKydu7DOpQLcb
	4ZWUnLGar95BEr2CBywUqBRZaqlqOFttZD6vFUzFRx1+FIwqPfXevxC2g9j+hSmifBdPphCyQh7
	R6UzXmBy4mITstv/lXGMKeyxAy8iJ44n2zrtPf1BHCIqKKRnWpJtBLuCxXcQg90q16PmQEsEUbz
	ECU0Dg4CtFW/4G+9Hvt2TLD8ji3dgtS2GW/8wurH6gknlPfofjF7TrA6yDmEgCHh6zomQp5BXpZ
	ylDfz1hm0vYjpCt3BkrWLVByYMq5HyD6KzFSB3tjRGrdFSsVA+sdQAaIUtylSl8mkKNFTm74PV3
	P8ZUDbcaCwX9TcYM0XsxKj4dQpISifz/4kTQ+6ShMtGOmGDJaW9dt3A7ClUxTJA/NwlY0nDbWJp
	W/n91AtunyegDBBBZGlgSK7M1L3R7mYNIj6
X-Received: by 2002:a05:690c:b03:b0:81e:b981:3eb5 with SMTP id 00721157ae682-81f99152f46mr28749767b3.23.1785311388862;
        Wed, 29 Jul 2026 00:49:48 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa29b1f9csm13559087b3.46.2026.07.29.00.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:49:48 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:49:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.ab3e673de325@gmail.com>
In-Reply-To: <20260728160935.4128982-2-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
 <20260728160935.4128982-2-joe@dama.to>
Subject: Re: [PATCH net-next 1/5] selftests/net: psock: Generalize psock bind
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Generalize packet socket binding so that types other than ETH_P_IP can
> be used.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>

I'm generally in favor of splitting out series and subjective, but a
few of these patches could probably have been squashed.
