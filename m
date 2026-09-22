Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B325B093;
	Tue, 22 Sep 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036423; cv=none; b=kl/6CQsNBAglyywneUhBFpIUUY3FXsp7X0zpnGD/CPje9ZxoLyTv5Ozv4LO0iqiXfQ8tSCUlf+fmZpt/JsHYojo33mW0XIwHTRzDv5BBT19hjN4sL3Ia6l6iHr+icLUYyLuTVdMG4YuPGcgkcqKYxdYJI2iPGg9Nie9p6Ia8fOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036423; c=relaxed/simple;
	bh=H4rUkloxqwv8Uiq2p3FwD21/mGoEX/VOhy5SF2wRlyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VemVJkXnH2KMg9Nwe0JkmcB/1FU46UfEJdbkGlg+9iJCb+wdsFdQywC3uSJ2/vYbCAVa5ylOZlsBKptZ0Bk8PqVXBa0yAswYuUx/RN5q+YLEE0nvCagHaCrsbK5rY39XICOc020yH80yfOknwQ0OzpdVHiV7fdvWJIchImEgqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clx+dcb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clx+dcb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434951F000FF;
	Tue, 22 Sep 2026 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790036421;
	bh=H4rUkloxqwv8Uiq2p3FwD21/mGoEX/VOhy5SF2wRlyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Clx+dcb3dBcvPm7pNZ1Z0JgHwvmLqjGtVPCAyZ0UX7msstm75O0ks/Y26cXHXiu2s
	 kP9fcsBMjEJjHMhcbGHCa/ilTlWsoDS8PyqomhKNcruwRSLB1LJ9vpHg5QTrZNG1vn
	 f+fzdPzE5G2QQXpv0tzWiqeqt1rHADTtm8iH2cfD2eWyMh46i2V7GLM7l07TELF3KC
	 yFoy3P/gPBpwe9AxyiCocQMn/zKOk6Zu32G5tteJzeFWpbbIp+fMzKR2Nf4Pw2OHUK
	 JX7RVSVCxuyg2TCMnSacoWV2X3DssW6mgdxi9lFcV4eOcrmrsCcsPb+NRC5jUvrmvP
	 x/WwJ7+Mu7OMw==
Date: Mon, 21 Sep 2026 17:20:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Milena Olech
 <milena.olech@intel.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] dpll: use exact lookup for reference sync pin id
Message-ID: <20260921172020.5e34d9c1@kernel.org>
In-Reply-To: <20260917143736.526221-1-ivecera@redhat.com>
References: <20260917143736.526221-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 16:37:36 +0200 Ivan Vecera wrote:
> Subject: [PATCH net] dpll: use exact lookup for reference sync pin id

Thanks for following up on this!
