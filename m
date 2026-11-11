Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394131;
	b=4Wg8P83A2nrk+iiNzJC8j6OC6JfIKQyZKOR93GTzGvWlWXu4pLgM+kdiJOwl1wSPjgf4
	 lXmDFI7oShCqMxpQ3nKDeXIf9X1ItWymbX1xIzPSecfEyh7KGgu+i+jYucZMwcSSzcqLN
	 CuH8kTmjssr+621XSHDW9wr+YyTpP0FbFDGB4CuahFuozzHhbWSUSjCx+5QMmBiNt66Eg
	 +D3pAvh87KmqGpJwkJn9Xgfx265tXJ8Q1FEM8Q3ZZERpy3m3Hp/kVER3wWdMjj1yQajRP
	 H3369c94AiAVK0MlXhCvzYCIoIekJaOoqESi/czjraYy/HVM0WzdN8S6d5CoG7XEE4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394131;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RqF08vHGuWiH65DocbzobUsEjzFU0GtZ5sZ7q95NlpI=;
	b=TzC0QzO5zK/IFPBqAg7/qgcfCPFN+vJC0jnfOQazaZkiKKTQXWVJ/MdqCS5UBF7J+FXR
	 GR4BwpO80hpjoZRMJAY0USunfZAs3ISVXlmsqCn5uctlBktn/bb5EaOoBoRtIdObUMnON
	 ejTKXZYflSNaMAtZq3mvD5UxyGSG+BW/KaXgoJyQ9v0hk9y5h3/YsvGcQZ6HoZXfE08dN
	 1btMbNSep0aUWXyXnE8haiQkjG0IWhlkwTQyGKvth+br7Eq4YnjlphHIPagp/kczR7xt/
	 wzCssWQj49lw0A73SckcuR3N5XzlMsspU4VpHlYubaNJNnA87MHkzkXKiQLOKE5bgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4DTNuvX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA1606A886
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4DTNuvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DA71F00A0E;
	Wed, 11 Nov 2026 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394130;
	bh=RqF08vHGuWiH65DocbzobUsEjzFU0GtZ5sZ7q95NlpI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M4DTNuvXq7TdsnCMIzZLwac1TkEWutEotzKYOnj52KZhCYF9NpW0kTXrwVBnrXm8p
	 D5qTXrrH5TIy+PoiBmcHkwOGIMEG027bSXbynRJl+uC/Q3uJ7VxMbniKOuosaMnavH
	 V8vO/bEBxZMJylDNR1JPT4rKuqTcojouFsrmJo3SFku7Jd+J7F6T0HAENwILDJOYRl
	 mQJYpcplkC+sf+BSw82OnhqXKl/tA1upYomsiY8i2P3TcHhW+NQy/WAR0VhwNZY6qd
	 Nsq7DHVhW4RFydpSuYXzJSEqUlZ9sOyjxviGozBQ6VaZTFatxofNNKN+IXecInUvax
	 pKc+JyMMevXDQ==
Subject: Re: [PATCH net-next v2 2/5] hv_netvsc: hold the VF's instance lock
 when installing XDP on it
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Date: Wed, 11 Nov 2026 10:48:49 +0000
Message-ID: <179439412975.2199510.3527577405382153114@kernel.org>
In-Reply-To: <20261109194843.1353592-3-kuba@kernel.org>
References: <20261109194843.1353592-3-kuba@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The stable Cc trailer contradicts the rest of the commit
  "hv_netvsc: hold the VF's instance lock when installing XDP on it".

--

hv_netvsc: hold the VF's instance lock when installing XDP on it

netvsc_bpf() runs with only RTNL held, so the VF's ndo_bpf() is called
without the VF's instance lock. That trips the lockdep assertion in
dev_get_min_mp_channel_count() and can race with memory provider binding.
This patch takes the VF's ops lock around netvsc_vf_setxdp() in
netvsc_bpf(), and adds an assertion in netvsc_vf_setxdp().

> Reported by Sashiko during core rework, the race was not reproduced.
>
> Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
> Fixes: 3ec523304976 ("hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[Severity: Low]
This isn't a bug, but the stable trailer still says "untested". The same
commit carries two Tested-by: tags.

The v2 changelog says:

> v2:
>  - commit msg: say that the race was not reproduced, rather than that
>    the fix is untested, as functional testing covered it

The body was updated to say "the race was not reproduced". The comment on
the Cc: stable+noautosel trailer, which stable maintainers read when they
decide on the backport, was not changed.

Should the trailer be updated to match, for example to something like
"LLM report + LLM fix, race not reproduced"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109194843.1353592-1-kuba%40kernel.org
