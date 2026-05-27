Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAD315D21;
	Wed, 27 May 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846176; cv=none; b=UHzX7bmVCF7ELkqw9KzKY4MXxLCe+aAZSzWhfb3EqcTd8Cy9xeAx0jvfNAYrqiXOSOqLKfWxnWMCbA0LccxfFv1hrDt53adQxfndI8/kRIBtsadKTqBIPUdsZByVrFXoUjTJkzgHgBgiWmYcYYu8T7F8sk3/UkIyTXwT69MCESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846176; c=relaxed/simple;
	bh=Wfve00Udq/MmHgRt+YK/GAb6kQxCh+B+3xMq2GlDguE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st5AJUBFrUuZYFHBeufKgVaN3l70hRdUHzW4WyIbXPMV1TdlKVGPb57tyzAmKP3461+Y81l7AxHa+eO/dY6qJz6uihER9jUZkVG0PlRZqG1jW/NYXgXrEcxH3XDnwHw24VFOK1DyGoLf+JjJQLYx6xRJihTVbbg+lKzqwcMPAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmxkmtxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmxkmtxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE8D1F000E9;
	Wed, 27 May 2026 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846175;
	bh=e2s6wWcR9a8fFi06iixE4pi55CTIhyEx6MtJAzlrCS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AmxkmtxRqScmI5UpQqKBwewVegleErQok+WSe+KoxYb9OCFdxk/dSPZVJm8Kyrr+L
	 AtqxT77398p/HFpNYODUuRg/5wA3/Qlgciv/PjIzlGUCrzbXLwkzYrAjZZ0HhySzrP
	 BuWfn3Iblg9dKGbHBY0NdSJ2g/FrlUGBOJeiQirjCpEQMCl/ID/QN+C7Yro66m5Vnv
	 QmxX0jI8LNmmTA2c65Wdu/d4Ark/AjbSGN4Lkm+RvF9ItSPXRMbIk1MfmQdWhYVm2w
	 +6sgWaV7eTlnwOyMVnfn5biFlp4sK8+bbr005Kq7itB9pUTSG+Bwy604/S6nQM3FdA
	 ptD00Fs/a4/Pg==
Date: Tue, 26 May 2026 18:42:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Murashka <yurypm@arista.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, mchan@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: tg3: guard napi_disable and
 pci_disable_device calls
Message-ID: <20260526184254.0eb2438d@kernel.org>
In-Reply-To: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
References: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 10:49:03 +0100 Yury Murashka wrote:
> Subject: [PATCH net v3] net: tg3: guard napi_disable and pci_disable_device calls

The "net" in the subject indicates that this patch is meant for this
tree:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/

to which it currently does not apply. So please rebase & repost.
-- 
pw-bot: cr
