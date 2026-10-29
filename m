Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290037;
	b=KoCsNbwxgoHJ0u7RVBcrG2DNnHKKNerbM4rn/ILLv0UNJbDcO/wuNkdKvulDMM5kUi7Z
	 YPU4T+wSTOyERg0lUAW6JpQg4N/2HVa1jeumHTyqgvGYnm6qoU/S7qtFzWJ/kKIqE6Y5n
	 W+2n4zmCIl99RJf2uKMBlHlLI5PbqZB554OJ62tuuSs6yLmlAuhNbRytbD7sm7iSKsxsW
	 ajXv+CzR3H/wlQvQlZRvr6PY9oqCCm6FwVfqOzs6RSfjsgHo3/6EqW+GichZs1AUmxqOz
	 Jis3SMVJ9rufeqFPndCocfXF+ZdgI76fTHEzxmXkrO5tgUCg9dkkr7dn50SDMIivF2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290037;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6pusSa3A5cdps9One/1KbVhimt45kuAJaKKTpojXqC8=;
	b=Dhod1QFz5AfQtIcoEtTs2cAVtWpvVSBRh97q01aMxrqU80iyLPE2R18WMNeElF/E/ZLg
	 eNfjXQNxmgM9/LMlELRcIuSCzrm6ASYrq08O2F/ZCngvhvP2WwbjuxosM9bLbWuoQufBD
	 ZBiLGIRalAj7BTiXTa8JYjg7qrPp1CZpf+jbNqop8abhq7P7pcScD7BxUxFW+KQ4Fs6tN
	 5sxRHY9Ypp0pdvxQ6zq2JTyD1+t09HlCYpNQniWlwR9FX/JqC2gCVEv32DPzBOiHdTvU3
	 fdHUWYkiZ1os0fl7vCqokwKBAqSApcWZnHPjKKSc4zXk7mSRR64ej5rVYaWU0xBpfYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Efty9sR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242E606A31A;
	Thu, 29 Oct 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Efty9sR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB89E1F031E0;
	Thu, 29 Oct 2026 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290037;
	bh=6pusSa3A5cdps9One/1KbVhimt45kuAJaKKTpojXqC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Efty9sR59VAPgQ6jmItiIf7UV13TSifhZD2TkcMjtyOI0vO3ZDwhptkW/V6HMbkwJ
	 Yp7nppuJI5BRMnbSUcGfksAUdaEoUFX2dEw/ePNn4jcU+DZgGkiSfikPuS7tgXPkDo
	 JFYS5/vzbJn+tDZfBq8NKJG0nA7NwyxjfogoE3Irrd7iGuK6+otM6Vp+8KBBvbkKQi
	 FiBznVuEZkjMGaB7qiDpKXdVxrSgUe85wGffX3JruIFJOkHEEkq+8bqzkrc++8j9du
	 cgqOqGaT8P2BuuTcrREZVXnT8f5+VpIkdrOtzUhobnU15XRfApgfgdnFR2IT/GDNWA
	 6UbaJyWfoq1gw==
Date: Thu, 29 Oct 2026 16:07:12 +0000
From: Simon Horman <horms@kernel.org>
To: Naman Gulati <namangulati@google.com>
Cc: netdev-bot+sashiko@kernel.org, almasrymina@google.com,
	aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
Message-ID: <20261029160712.GK257209@horms.kernel.org>
References: <20261024030401.852598-1-almasrymina@google.com>
 <179289749460.3134.17105687099040790537@kernel.org>
 <CAMP57yUindVWCLV4O=Qki61VmZ2y8hjMPVJ51UnODz3D0LKwXw@mail.gmail.com>
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
In-Reply-To: <CAMP57yUindVWCLV4O=Qki61VmZ2y8hjMPVJ51UnODz3D0LKwXw@mail.gmail.com>

On Mon, Oct 26, 2026 at 02:39:40PM -0700, Naman Gulati wrote:
> On Sat, Oct 24, 2026 at 8:04 PM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [High] The fix leaves the skb leak in place for HW-timestamped packets,
> >   and the Tx timestamp latch they hold is also never released.
> 
> Both issues are pre-existing. This patch does not introduce any leaks
> and these should handled separately in the tx tstamp and FLOW_SCH_EN
> code paths.

Thanks, agreed.

Reviewed-by: Simon Horman <horms@kernel.org>

