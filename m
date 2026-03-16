Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7B36C0D3
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704516; cv=none; b=fLBYETgjkKaFAb946VF8C2rtsWPe8Cup97SzyJ1oOQvTyrUjEQDn2+Vg6qlJ58eUiDET4fuRHNoVX0q0uzIwqau4hCoI4zcttIhTh+YyUVHAb0AaYQzeG8HmEFlBSz/gu+M5QoZTd3jPse2He8Jhn75XhwesmB2bKA0EaR8uhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704516; c=relaxed/simple;
	bh=GPG40qgsiWGfnf1HBeZ8ASKYrpHqfbll19YA2ateEtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kC5meU9lOfs0ZwLarbee3lP/Axh4AMAJ9x4ASZlSEYmlkQKfa26Seq1NEdzJBOqpn3WjyicseKSc392A7u8g3wmQEwnhP1XQfpbtofaHIqR9xrDH0quDKbB8e9kNRb2T/VRqUm9pE6Tlcukvp1sPZpTuA7o/wipP+7hGre/u1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=XxsvWGDu; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="XxsvWGDu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773704505; x=1773963705;
	bh=GPG40qgsiWGfnf1HBeZ8ASKYrpHqfbll19YA2ateEtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XxsvWGDu/IN4vUaX8G7/9dIgPzaVfiyArlcXkWH4G7abI6Haa7C9Ko2IGiQgo67ih
	 rwvUBxlImxJrkqvaHWz/x7hzBJgPfkl7r9gwjP8qf99ScHvMdkyYYXYZ47ZqCB2Ktk
	 vZKjDZMBe3Xa00zJUlOUGaujz0I4hasJpxdPX+x5XXKTAJM7soR++tCvUApSofjUC9
	 epDDXM30IZH/N008XSqu6JpLGinjpYk6indAXTk3YHJj6mYJ+Y5+X2WkDDzJQChOlC
	 fDhIvN45U8guqk4WuSwRVdA4zs9qAuphSv7+tkipHA4oTaY25k9aLlug2gunPrFkiy
	 kMvWfF9ux9rFA==
Date: Mon, 16 Mar 2026 23:41:41 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <kml9JrxcP_XGGG4SSCVJO6f8Oi9zTfdJg9NRVZyvu7YAd5dgDy-uBE2m1U6MVY-ponQRFLuWQ6z14W63DCLevPICexEWX_yMQcZrytxCgDM=@1g4.org>
In-Reply-To: <20260316161247.1f472be5@kernel.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org> <hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org> <20260316161247.1f472be5@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: f1e5586f1442cebbc8c2d3a2fe4677b0d66b1bed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Do you actually look at code anymore or just mash a button to generate summ=
aries?



-------- Original Message --------
On Monday, 03/16/26 at 18:12 Jakub Kicinski <kuba@kernel.org> wrote:
On Mon, 16 Mar 2026 18:45:48 +0000 Paul Moses wrote:
> > This is not the right fix. The shaper hierarchy as a while is not under
> > RCU. The problem is that we take a ref on netdev and then lock it,
> > assuming that it's still alive. But it may have gotten unregistered in
> > the meantime. The correct fix is to check that the netdev is still
> > alive after we lock the binding or take RCU from the Netlink side.
>
> Ok I see it now, I didn't care about anything except queue because it's t=
he only
> path that affected both drivers. This is an entirely different issue.

Did you write any of this email or am I just talking to an LLM?

