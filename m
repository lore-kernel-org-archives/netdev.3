Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716D25F988;
	Sun, 30 Aug 2026 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124246; cv=none; b=AcsHXE5afc1am0WFmdIVr99bSueFmot/fL9iwuYAKa8peOP9dAel1GuHe6ND85AHy/Pk0QwkpTihnWgyf/hT5IiieyekFVqgGo+zi0qPFe/RuG2VFPZAmEMaeax3DlbyyP1b/sa7ZjLr/LHzWLXuA1GiWjKTPKTcBHKQceY5Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124246; c=relaxed/simple;
	bh=kdS0GESIujRFhnDASP5n7ZVdQTen91dMeYFEzHwCn0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOP2qaAp9dOoz+/+uBckIIMjoBJtKaarszoaTf1Rg/Rqm7p2wocFJ4TP4tpJGxZOEUMdOFoeQK04ZViPYu4MVyE+V5T1XX+vkOGDXQKHl82x2bKodA959fBL2HOrdvHkYMwYKWmulKeNUPYjhfG7u4SyB7a00E+Qj+3jiK3q+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj/30IOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj/30IOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B751F000E9;
	Sun, 30 Aug 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788124244;
	bh=ymZJ/kBS7WtLkhww3I7roT4Upf3Ue1DCyuCrplRmqJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Aj/30IOuUyN5IdK9jcc3RB+HMecAzvWxkWWBTmTSvq5dOs7jLoXTZmnAMFvBqUtRR
	 a1AZGt3PA6+B9PimLI58UGRG3Kblt8+Cs5dFAKjNthwfuCK8Ikjp9YGB3To4VSHrFU
	 9udBeh7J4X1ncP34O8FpE1BNd4LUsGWY6tipEkq556RbqaWp5kpB16M5A2+lxcFO1d
	 PUvRXovlhJFi7TNyUxRevomhlQiRXcXACc0xn+1zKP6mdL6VbqK4mqyjf7y8zWkaqI
	 qepormRwaAyP90Vdk1GR+c1PJBTUNkbBksDkw7cCcqgdDy/ps2UVxH4I59n6lc/Ehl
	 aUYYCB0EVroDQ==
Date: Sun, 30 Aug 2026 14:10:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jacob.e.keller@intel.com,
 syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v2] devlink: request flash firmware without instance
 lock
Message-ID: <20260830141043.564ca0c6@kernel.org>
In-Reply-To: <20260830140157.5de02f7e@kernel.org>
References: <20260830111700.1799255-1-miguelgarciaroman8@gmail.com>
	<20260830140157.5de02f7e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 14:01:57 -0700 Jakub Kicinski wrote:
> On Sun, 30 Aug 2026 13:17:00 +0200 Miguel Garcia wrote:
> > request_firmware() may enter the userspace fallback and call
> > try_to_freeze(). Holding the devlink instance lock across that call
> > triggers a lockdep warning and can block unregister for the duration of
> > the firmware fallback.
> > 
> > Drop the instance lock around firmware loading in both flash update paths.
> > The callers hold a devlink reference, which also pins the parent device.
> > Recheck registration after reacquiring the lock before calling into the
> > driver.  
> 
> How did you find this issue?

Ah, I missed the syzbot link. Sigh.
