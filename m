Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348162;
	b=ZRfN/AXXlGwceusfXdtjNDS45JO8o0kZaCeaLlqqyOncAZsBI6QwK90P4abSx3TimbWb
	 kaRs1YRyv43IimkZifwfLCWQIH8id78sk6hIhJK0PQOvYQk9ECRgOjdCxCs8H6uGaq6ic
	 O2fNTlBGSC5mBfNhIxP5u+4eBOXKsLMzDeltImKqv31nMIsWAorb4CP++mafNd55D0OKB
	 nd1/w1fmOZg26d4GwTrTl6ERsncyg2ofjjdHY4svYPP4c4NWsZr1amt5YggM6vmjoZ0c+
	 /wzywUdGikNN+xXA/+1F9A5IIZQ35BFsxNYq96IPgPORSnfj4HGDsT84GrCDbYWTS2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348162;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bHFRgpK0GhUOKpvqvTgbaax+1DonOevI+N7r462VLc0=;
	b=YvjpMVa3UUBodsFuaKxagWuAmEqarl85aQMXxEbFc5zxjIbk9QJ/bKZHhW12SCf1VIRA
	 c7yuCvf2f51QZl0PM5mQd46IzXbwQqVmB2rG9KuS9lDsGfX/XfejauWAwsIQ1n72R7/y1
	 +zCGvdMpOvIU/gdsjMlDRia/hgaCs00effi6BSN5P5HXhLkWM6RKB07LgmBLwHrTu4Jk4
	 ypxXeNVAV+muPU38zO0XQR4vEQmBuuam0VO92xe2qeHkk0nLA4iUyk8ewfz0Ivnzu4guE
	 PnphNXt4NiwRcGpxdS08SIUXaJDyulvt40TOk/sDXDDhxASlnvP4LG4VdKmCLSAtKlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfgv9TAy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AA606A31C;
	Tue, 10 Nov 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfgv9TAy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8321F0089F;
	Tue, 10 Nov 2026 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348161;
	bh=bHFRgpK0GhUOKpvqvTgbaax+1DonOevI+N7r462VLc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bfgv9TAyeOaEcNbYlVqu67lOlKxGWpwxtMYt91cZflFsGV7xzmjLYZcJqYy0tOLJz
	 mPNszwgp4GPRd4OqFes2sTdEQiChNOTfVbNNr0sGY/Lrz+J53MESIqVJ6gWnfWRoRZ
	 u9whiq7fZg3yWwM41vJLFWIt3YO+5cr68eCtcZphhvtRpyhjNvCMXwn9gzRrkDG1zm
	 iW/R/e5fuFC+94k4I1B5LRRAYJywEdhKKDAIIg+7ffpqOkOwrBMfsUgGyb0y73r6ml
	 w25L6dlMhIAaZxgdm3diLpTVpKKSFdpIaakzzVgr+COfjoOubJX8uVxqH2n0g7voZ1
	 EMVSOVwshIE3w==
Date: Tue, 10 Nov 2026 14:02:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Milena Olech <milena.olech@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Michal Michalik <michal.michalik@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] dpll: report dumps interrupted by topology
 changes
Message-ID: <20261110140241.422a981a@kernel.org>
In-Reply-To: <20261105131145.1010406-3-ivecera@redhat.com>
References: <20261105131145.1010406-1-ivecera@redhat.com>
	<20261105131145.1010406-3-ivecera@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Nov 2026 14:11:45 +0100 Ivan Vecera wrote:
> Pin and device dumps release dpll_lock between parts and resume from the
> id saved by the previous part. An object registered in between is missed
> if its id is below that one, as is the case for an object allocated
> before the dump started. User space gets an incomplete dump and has no
> way to tell.

This is not really a problem, just something AI loves to complain about.
IMO dumps must be correct only wrt unmodified objects. If we have
objects A B C, and A and C either get registered or removed during the
dump - whether they appear in the dump does not matter. Only B must
appear. If the IDs are from Xarray they are usually stable, the problems
with dump consistency mostly come when dumping a list or a hash table.

Please repost with a better commit msg if there's some list / hash table
here that I'm not spotting. I'll take patch 1 as is.
