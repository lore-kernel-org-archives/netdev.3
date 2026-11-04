Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804692;
	b=dJNfLT3eXYXQczXl+lAMcNhmKHQ+s6vwwl839qJpiqE0yG5K56Oh+aQUu17eSC3ebtp8
	 YEdRIFcuukQ/HeL7aZgdPYnVXq8zJFjmABS0HEeYmBBT8+bTVKwsKzl1XXCmsal6HISE2
	 Orrq2i6lE7i0SjSJfhP2edQLjSDUv8LhX3SDoC8aULhsO5Pp7DID8Y3+EZxnw3KdlG4Ls
	 gXLrBrmBVMn2qpHv9EJA2YifhfLTZ8574vLEYIlBZA5zPXRn4VmTOBbCKKc43iIaK8xqa
	 9T6e99VR5BWUUYrke55eOTkVy/m+0Ta+TV80Db9YHJYQYAq75LGFBiaGQa3NNGFR4lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804692;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=i8zBOxs8Ae4bkhntsdE/C7UrckZAzOvmJQWIjhzIE4E=;
	b=XR7wtwZF1ohcHVXJaKpfn52NMVymlNe99+l3GGPs1E0/YQjbqc2VZbupYeh6FTaCLoKA
	 ZO8rZpUQiRZZhok4xGsNH4IJ7IKhq2FFBPqvSQYWm0lpsrgb/VZ/QfmbSJEa+yRHIV3lK
	 Ys4Fut6f8rOst32qwwNkbyaw10vkNoJzV/Aav/pYgWU7mu9PfO4LgYJB2FnmKUqMy/yvs
	 DqAnSsvTfUVREOJxd+gRTgTj/XVkBBMvP/iCRkQhvslMtdysojr3UHizaN7ZblL3h4JvK
	 5J4P2Dw5E5EATnmWg5ITWvlD0QB58Kd0VxPImgG7TlF94/5sjxkTe5BQGAVqFoXKdtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=H31mNip+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ACB606A32E;
	Wed,  4 Nov 2026 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8ACB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=H31mNip+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=i8zBOxs8Ae4bkhntsdE/C7UrckZAzOvmJQWIjhzIE4E=; b=H3
	1mNip+XQpqB6nLMi/ghakAGKYU+CQ/HSX4zBcmrEjKffoijR5ffYode0JT7OW3O84ZAQIOq7TPoZK
	+LZ8wGJIvvLG6p0Y+npOqxlBa6xN0paY1ZOWyrEE/MtOS+XtMz9WTU98D4unACTMkbBZm5uE2dkyJ
	/jvlDuq1esYzQoo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOcXc-00EL3l-Ot; Wed, 04 Nov 2026 16:04:44 +0100
Date: Wed, 4 Nov 2026 16:04:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: motorcomm: Rely on port isolation
 for CPU port
Message-ID: <de4954a2-8d01-4a6f-9641-230e9faca4cd@lunn.ch>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
 <20261102155641.3682626-3-mmyangfl@gmail.com>
 <84089fcc-0150-4464-970a-09400f3ec5ca@lunn.ch>
 <CAAXyoMN4ySBtnLjqKcfAa4XwUR14-fjaJh-hcCyumERagmcHvg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMN4ySBtnLjqKcfAa4XwUR14-fjaJh-hcCyumERagmcHvg@mail.gmail.com>

On Wed, Nov 04, 2026 at 06:05:32PM +0800, David Yang wrote:
> On Wed, Nov 4, 2026 at 11:59 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > -     ctrl = ~priv->cpu_ports_mask;
> > > -     res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
> > > -     if (res)
> > > -             return res;
> > > +     if (!(BIT(port) & priv->cpu_ports_mask)) {
> >
> >         if (!dsa_is_cpu_port(ds, port) ?
> >
> 
> The next line is ctrl = ~priv->cpu_ports_mask, but could change both
> if you prefer.

The advantage of the dsa_is_cpu_port() is that is it very obvious what
it does. And anybody who has looked at any DSA driver knows these
functions and what they do. So maintenance is easier. The more you can
make the driver look like other DSA drivers, use the same constructs,
helpers, etc the better.

	  Andrew
