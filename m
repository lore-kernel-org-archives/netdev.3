Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566C45D5C2;
	Tue,  6 Oct 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299472; cv=none; b=kETfSuHQTOp4rMANihAZpgGaKlHuMNgudHH4wQOdwyEnXNzFoWR4ANKdiE6N5YAL6fnj4iLOPxTIOP8hcEWwnHbwFIUYugPWzdXgtS1Mk7Fn44D4zEjOWm3fscKFh6lIokSsTafIDp8qAq6Jxh1XziHyEg/oVJnq8qQB/PmiUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299472; c=relaxed/simple;
	bh=ICEwzRSwMVb86LWq0flyFit50IBgkC/+8wTWkQDOvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+K7pHoABa3HZ9wxtg/Pso/zJbEhL/YC29RcxdFcnrsY6NbzYx6h81pGfyY0zYpCx5Gi3EwbT+2gK2ZTn+pvxAOnMst6U7NYRj83A3PjphmR/po1gKGOLIqOD5I88FiY+xl/1j4cbQVdIDxg8wH7POfhoZEThQAr14CacQ8iq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOYqORGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOYqORGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744091F0089B;
	Tue,  6 Oct 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299470;
	bh=ULW9vKRbgYcfVx3QsuSyDwqIJAfEuuNW/5xpKdjfHdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOYqORGarKp/msV2EqO5hS1Bnco4I56Lbe3Q/vwXx1ffcC+ieYWsauhLHUpgkRHe0
	 96BARLbefkSD6HWfHgbPPixICfAqjNGm2xlEX2WL9BQ8WADL1mGqXp7e1i4TWYXndT
	 gP6uAatAQzid669U4dvZhbtjPXCoSSQxcoAhsUOtGz6TceidaYO70PO9MWPvbHKXdL
	 tJGoL7vp4lO2xdKHEkaExELqWVz+ZZYSBrZSNMrCR7Ld1gcvogXRyUcYqXAmxUMzYc
	 hCFTK2R0TudqUZm1xBLTyn9+jdu8udhZ52am7jZnMRTcQHGbPSf8htl76/qRnHPGm9
	 ORfpYrl/BvCvA==
Date: Tue, 6 Oct 2026 16:11:07 +0100
From: Simon Horman <horms@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Message-ID: <20261006151107.GJ83879@horms.kernel.org>
References: <20260923234819.702327-1-oss.patchbox@gmail.com>
 <20260928091551.GK13925@horms.kernel.org>
 <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>

On Wed, Sep 30, 2026 at 12:06:48PM -0400, Yuho Choi wrote:
> I appreciate your time to review this.
> 
> On Mon, 28 Sept 2026 at 05:15, Simon Horman <horms@kernel.org> wrote:
> >
> > > Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
> >
> > I don't believe that commit introduced this problem.
> 
> Thanks for catching this. I'll fix this tag.
> 
> > name is allocated by kasprintf() which is a wrapper around kvasprintf_const().
> > And kvasprintf_const() documents that it's return value should be freed
> > using kfree_const(). I don't think it will make any run-time difference
> > here, but perhaps it would be best to follow that convention.
> 
> kasprintf() uses kvasprintf(), not kvasprintf_const(), so the name is
> always kmalloc'ed and kfree() matches the kfree(free_irq()) used on the
> normal path. Please correct me if I'm wrong.

Yes, of course you are right.
No idea how I managed to muddle that one up.
Sorry for the noise.

> 
> > Also, for completeness, shouldn't there be error handling for the case
> > where the allocation of name fails?
> >
> 
> Agreed, I'll add it in v2
