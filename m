Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CC40F8C9;
	Wed, 25 Mar 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462062; cv=none; b=SThug/ADY6S7acdxRyr8lZTOuN8We15OlgZqjycaUT6Z1q7Br3DofqUkvrgy3nY2p4WpOTil7DIhystSgoB7aebariF1+s5j5VoenDyCn9g68NrUNofrYABEeYfM9Ei7ptuQY8hcTAYTDhQnDPSKtLxwTRFTw7N9M58hzbbg85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462062; c=relaxed/simple;
	bh=VrERmH7NL2hhZTiixHtA35OHq9oJ+IK5B/o7+2UsP8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfUP/JmYCvvUMDIH3BvI3qgB0J67LEFM/G0phgG6WXZoXkfPbHWmfQxXAWBM+C7Ih05w3NnsHcQJ6SjgrnjlbzzlXu5RJOQgNwMVoztY4b9dCqblHfk2CN1I2mw6kJ8Ee/1/pjhsqusfIOZpYGE0G/3qQIQfLJ8ivMyf5ZYhBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4IzPVN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4IzPVN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75670C4AF0B;
	Wed, 25 Mar 2026 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774462061;
	bh=VrERmH7NL2hhZTiixHtA35OHq9oJ+IK5B/o7+2UsP8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4IzPVN8Bdfh8y5p2WBPwl4Vic0lUV72G8SC1GJbnGj6Rn6oUG+k4rFEquBmIGCaH
	 qAbJ/w/xTTgTnrCXnN/SEyifpyKaCV15V0fsw0nj/ElQYF9Ut0w/eSvlPpxWGrTXhc
	 FyrnPVC6/GW8HtaELt5kwZGcPp8fN0jN485BGhj9G2NIl+IvDLJyNntZ1r788P3I2I
	 ZmYaYdMrcnDou5KPQ48jIbYiizg0z/X4vRv2Iyg5uwhqDHWhPDTbotAPTp2/IXLZD0
	 Ndg9YVMO08zEm+e9PsLlThv7RwWcCfqHecy+Z95alvKukjt2iSjR1G1Cm0GLGnzICf
	 I/nvVJmHFpdCg==
Date: Wed, 25 Mar 2026 18:07:37 +0000
From: Simon Horman <horms@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: fix endian handling of confirm_rx field
Message-ID: <20260325180737.GM111839@horms.kernel.org>
References: <20260324-b4-qrtr-fix-confirm_rx-on-big-endian-v2-1-674fb3f4865b@westermo.com>
 <jwqcbxfhnzbxn3iwvoe3shtfttio2pjsah3pkwknzqvjx4xfp5@nmfkkgrjxkhk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jwqcbxfhnzbxn3iwvoe3shtfttio2pjsah3pkwknzqvjx4xfp5@nmfkkgrjxkhk>

On Tue, Mar 24, 2026 at 01:28:32PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 24, 2026 at 08:50:33AM +0100, Alexander Wilhelm wrote:
> > Convert confirm_rx to little endian when enqueueing and convert it back on
> > receive. This fixes control flow on big endian hosts, little endian is
> > unaffected.
> > 
> > On transmit, store confirm_rx as __le32 using cpu_to_le32(). On receive,
> > apply le32_to_cpu() before using the value. !! ensures the value is 0 or 1
> > in native endianness, so the conversion isn’t strictly required here, but
> > it is kept for consistency and clarity.
> > 
> > Fixes: 5fdeb0d372ab ("net: qrtr: Implement outgoing flow control")
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Sorry if this contradicts my review of v1.

But as this isn't strictly necessary let's target net-next
and drop the Fixes tag.

...

-- 
pw-bot: changes-requested
