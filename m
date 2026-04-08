Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5422494F0;
	Wed,  8 Apr 2026 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667655; cv=none; b=M3ouX4RrW+fITlZotXUy2sxvovb4Vg9lArcmQOeEXEiWJfv2o0ShOKJP8luP7cro265OhnwNLs6glF4UwlE52GCnXkD9vv+idn+VN6FWESyfmarmHtiaJ7hyrCdgxkzHC0wU4hUjBfjDe8OZUOqeo4rFycmxdbPZAjgyzD91h5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667655; c=relaxed/simple;
	bh=txW/5bgq3qxkYi5rFH4KNs2USZACuaB2kGvhW4xVL04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebvQwENUWvmxS3MTu0zUBuBvMMaOo9SrUxz7Wr0c/q31El/hAKyRzKv69V3YfsUsd0/J21k+8PPEGp+PTmPCi+dnnFTWBj8NQIOU/HaGfhFutEnURdqhT0nBcg5klRTYHz7jnBaGHKhgUg2dTgFcQdEZgYoNXXDUxnDtozEbwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLrMgRdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLrMgRdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4EEC19421;
	Wed,  8 Apr 2026 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775667654;
	bh=txW/5bgq3qxkYi5rFH4KNs2USZACuaB2kGvhW4xVL04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLrMgRdIYpMj49/pFhHB72wZlDWZk7TFX22M4FfrqdRsYrJ4sbXr4ewock4vozXQg
	 jxiBKX+qkOjGx0yBs75ops/o6bzX8gcOXXfyCZhwe6Eiu9kzsGF486Rr/rAbBdl4Kj
	 EH4Eq+mnhmV3/DcpiFURSWM0rhqtDzb9T8HSS8+U+zOb3QkkD7ixj/fqxRT+5R7tUG
	 ciMqBUGv7Cj9Tb5/gbC2OCEf2+/SJtLzqAmEddVfZfdVL8IfrWGhlT78tY+ONwV7ix
	 3uEv7J/oB7DNpAoD/caXf66CmtdZ16eCL27AY7a+ERe/xFVtH/HhdY/ycDHs8WPTBa
	 VEbIT5AV9dc6w==
Date: Wed, 8 Apr 2026 18:00:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@6wind.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the netfilter
 tree
Message-ID: <d9d4e328-6668-4c24-bace-77a0f93bbed6@sirena.org.uk>
References: <adZhwtOYfo-0ImSa@sirena.org.uk>
 <729b748b-e00b-475e-81e0-a666eab24fc6@sirena.org.uk>
 <8d216893-1e0b-4e3c-8609-eb3de5da02cf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYINhNONE6Z0GcIb"
Content-Disposition: inline
In-Reply-To: <8d216893-1e0b-4e3c-8609-eb3de5da02cf@kernel.org>
X-Cookie: Often things ARE as bad as they seem!


--fYINhNONE6Z0GcIb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2026 at 06:43:36PM +0200, Matthieu Baerts wrote:
> On 08/04/2026 17:08, Mark Brown wrote:

> > This also needs a fixup for a new jump to the error handling paths that
> > was added in seg6_build_state().

> I also had this other conflict there, and I did this when resolving it
> in MPTCP tree:

>  +	if (tb[SEG6_IPTUNNEL_SRC]) {
>  +		slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
>  +
>  +		if (ipv6_addr_any(&slwt->tunsrc) ||
>  +		    ipv6_addr_is_multicast(&slwt->tunsrc) ||
>  +		    ipv6_addr_loopback(&slwt->tunsrc)) {
>  +			NL_SET_ERR_MSG(extack, "invalid tunsrc address");
>  +			err = -EINVAL;
> - 			goto free_dst_cache;
> ++			goto err_destroy_output;
>  +		}
>  +	}
>  +

Yes, that's the additional fixup I mentioned above - it didn't conflict
for me (well, the exit path did).

--fYINhNONE6Z0GcIb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWicEACgkQJNaLcl1U
h9Auowf/Q1sEhEnk85OYPN+TNs34DG0J9BOCLEj0soJkYlCnZPbORAKoPLS1eyo7
lvlaHXZH0OpRg+YqIduePvpotl6IkZzYaF0G294udf7jKTGRehVUHHC6mtbjKmJ7
spIQl0a/jKXtH5v0x5RhTdMgeiGIddd/qKP368+DZj7UP7r6BbL8i0pwPCA0LvkT
x/pOqAFsLjLO/4WdA0cywfAMEYmpz9vVJ4X9H8rCxlMe0XxSiS9lPIeJxFoDd/mz
X7jQ93RqYZdJ/HyVz7VFv+fe9tqfxdWbwFNF8Dt7TQFtP+uIuwy03f3XBFOoj+3N
IAQGfnSZa+6+c92tRfmnTDEz+3pHnQ==
=ZfNt
-----END PGP SIGNATURE-----

--fYINhNONE6Z0GcIb--
