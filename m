Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E3CA6B;
	Thu,  6 Aug 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025236; cv=none; b=ZdPWtuMUfrPY97FkD71ea9E0iaqh+U+GnBCb7pjpZ0U92zFCLTicdlUnuvr2VcghsDXgRgkGpOLBVfIWqiZwZfhNFbZPtA76GuPFFs5kP/Drh/y0kiGROJ59vwrbDlv3v6Xe+o1ZqC5WEz/0YE/MDJ7Ip7EVttlCKQjf+mkHF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025236; c=relaxed/simple;
	bh=RTUs026OW1uVTxFaWhPjlATwr3UqVbBnNgynTK9HPxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkgaG/5n3NHvxbhCsOiDWPZ903MRwB23i9iWjYzE7HE0fCXPe4rIgg8RGHa0eE7bN17X3jzhGQ34bainr1mdEUrHXCJf1RviLr5u3mgtEEiGhqv3EQkZ2wctds374Cq/uvBUAfWrN4QIe95s/oajfo6OMCz663+KbZc3pPcHKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaORSHI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaORSHI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D381F000E9;
	Thu,  6 Aug 2026 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025235;
	bh=k3a3ifP5IMKFLXdbCH50xG8bj+Kz8HNErdzR/bUk5A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aaORSHI3YRWHujPcv4PFyNZ6HJ+WndsBm7pMDxLRMBe1kiP4vQCSqGqH2lUicoePz
	 ccXht46W/ITYEE+Z1Z6dlUcSYmsk4eumP9nsUk6sgTnW/XlLxK2Q2qtaK/74ku0oEg
	 Noh37UGsSHMp9MDDKhMiuV6pYX421yQKMtGq9b6RKCc53f/m0na0JJ71OC5wHprT8o
	 gJHjV48mObm71xovh5QheJRqYoxBJm0Yb/j4xokWLqrdSqMbj5ZDbPdUpt5rfVqH6k
	 0LGM8CvM9WoxS7rXpm4J3ZaAsJ+IAFzYof9ZO1pzkMjQCHTike91O9JZHHILUHGRRZ
	 FEsJg+DFDM6Kw==
Date: Thu, 6 Aug 2026 07:07:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH io_uring-7.2 1/1] io_uring/zcrx: fail non-qops netdevs
 early
Message-ID: <20260806070714.5ee4d932@kernel.org>
In-Reply-To: <511377bc-7703-410a-8982-3050ad27c066@kernel.dk>
References: <23ae94da6725cac660652781b3533a20d0a1ad34.1786016493.git.asml.silence@gmail.com>
	<178601764913.2132084.3867669701970816639.b4-ty@b4>
	<20260806064958.1b9ae431@kernel.org>
	<511377bc-7703-410a-8982-3050ad27c066@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 07:51:22 -0600 Jens Axboe wrote:
> On 8/6/26 7:49 AM, Jakub Kicinski wrote:
> > On Thu, 06 Aug 2026 06:00:49 -0600 Jens Axboe wrote:  
> >> Applied, thanks!
> >>
> >> [1/1] io_uring/zcrx: fail non-qops netdevs early
> >>       commit: cf7aa48151deb629022a8b0c61c139dbfa579933  
> > 
> > I asked for a different fix :/
> > 
> > https://lore.kernel.org/all/20260805165817.7e1fc367@kernel.org/
> > 
> > Outside subsystems should not be poking at random fields and making
> > guesses. The assert is simply wrong and should be changed.
> > 
> > Jens, can you drop this please?  
> 
> Sure, dropped.

Thank you! We'll probably ship the fix next week, FWIW. This week's PR
is imminent, don't want to rush it.
