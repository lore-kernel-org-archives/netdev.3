Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CF236A73;
	Wed, 18 Feb 2026 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374075; cv=none; b=E1gi3xMNvsOlSovAValBufeNHkFnVt9yeswWwGs5bx+uRYwyxgcpXdIGDyqO8QNlOHC1WhU1Hh4ChgzqcsN8wAZ4yNWwLgJPVdGHshN6kqghgXuZBWOM/0i5GE4TAGweQkMzWyVo8MZAyxX+VM3i5atDrYoQ2/iwrsxFwMHZmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374075; c=relaxed/simple;
	bh=Gzi7z+Wa1KN1CxFa+GSLlVp5iVlsfjki+tsa87Akta4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lowa6ALAi7V1sABpAwK6Gq6PMYYW8dfl5Q/jTOEg7Jvjh4dAvCxaHcDCVjKTlyQZYE68WM3pk4qtZ91Cbgbu2WWa6JbA0DrULFw3srxSAWy7LA9N2788tdvKPDH6C/s1HNM14tXAc4bttbe7hX3754pq8hWsD3uQqmjZuV1hyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV9WXpaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV9WXpaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72658C4CEF7;
	Wed, 18 Feb 2026 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771374074;
	bh=Gzi7z+Wa1KN1CxFa+GSLlVp5iVlsfjki+tsa87Akta4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CV9WXpaJth0fwdYRoaYsvb6jaUQzJemtrkj/HoXzyirO74GudzHF7PA/wZT7vW+bN
	 5fQN7D6AeKi/8Oo1x02w25GM4ixbPo6TViIJSyxny9fcTPl2wXyjSc0RdNHRy1LcLb
	 E0wamQ14mXI5CvOYOoW3UU7AkrV9z4gMKP8fQFAg933MDqRQpMcN0G2Mw5kYncXmc5
	 cpxPcdq9l/miK4ZPQEgNSWt/z3tRX0lVuXp4P1t3A4GYiu7yiYNR1A0sU+UUMA/Lvf
	 cHdC2NvlD4eJBKZfj0DYAM2EAxCZYvotT7J+fLs4T/ND66kdg9xUNwSuJ7H1A7QU+b
	 eyMHZqZNmEu5g==
Date: Tue, 17 Feb 2026 16:21:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Lukas K." <kernel@0x83.eu>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 linux-kernel@vger.kernel.org, krzk@kernel.org, regressions@lists.linux.dev,
 netdev@vger.kernel.org, Michael Thalmeier <michael.thalmeier@hale.at>
Subject: Re: [REGRESSION] NFC broken on Thinkpad T14 Gen since 9c328f5
Message-ID: <20260217162113.12ea590c@kernel.org>
In-Reply-To: <d73ccfcf-507c-4c22-beeb-efc24f671626@0x83.eu>
References: <11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu>
	<b82d8cc1-2124-417d-95f8-5fed429e2d0e@leemhuis.info>
	<d73ccfcf-507c-4c22-beeb-efc24f671626@0x83.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Feb 2026 01:25:29 +0100 Lukas K. wrote:
>  > static const __u8 *
>  > nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
>  >                                        struct rf_tech_specific_params_nfca_poll *nfca_poll,
>  >-                                       const __u8 *data)
>  >+                                       const __u8 *data, size_t data_len)
>  > {
>  >+       /* Check if we have enough data for sens_res (2 bytes) */
>  >+       if (data_len < 2)
>  >+               return ERR_PTR(-EINVAL);
>  >+
>  >        nfca_poll->sens_res = __le16_to_cpu(*((__le16 *)data));
>  >        data += 2;
>  >+       data_len -= 2;
>  >+
>  >+       /* Check if we have enough data for nfcid1_len (1 byte) */
>  >+       if (data_len < 1)
>  >+               return ERR_PTR(-EINVAL);  
> 
> If data_len underflows at any point it'll wrap to some large value and 
> the less than comparisons will yield an incorrect result. Using ssize_t 
> should fix that.

Could you make this modification and repost the patch?

Keep the original author, since Michael wrote most of the code,
just add your Signed-off-by at the end.
