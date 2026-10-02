Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7E3F58C1
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971407; cv=none; b=AjiX/Z+14gr10sh2uWhZYmpIcT1rC8vTV72ifVOVZlSaI1zgPe0+D4MqL82oHZwRtzqNLb7LoONNsNyPE+Bp7UnNBhePCaYDLTi571Am40eIpcOVYsGpzlD5YQrcgdxQuUzbWiUDNfqQnAZFoDId2Mn6eazFjMQkl0sjAe2odRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971407; c=relaxed/simple;
	bh=zSYaGGZ7GLVsPeFAc1YOlGRfs+EUNgFEVsvGue+wp9M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YmYTR/m1ccf3pdULHoaebZ3iIh9LntsJIpgWpThH1hcm8BXiZNcOin3AavIoce234/5U2wkj7405RCghgPagtqGYFPP9cWyMDvf8zip0nyM3gEfgtfgU2VKEXfKhjFxbBNmeyqD2/FN2T6W7qI0hK/1pN0al4pb0fYuV1gHv/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5aJ8bp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5aJ8bp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431DE1F000FF;
	Fri,  2 Oct 2026 20:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971406;
	bh=Jg/crF/xmROz8tS18WZlle1uh4qoMj7W+Z/9qEUbzUo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l5aJ8bp9ePIh0eZUPnkV1PLUGbiRS0i3ig4yRDK4n4Ril6t7JtBC27HezYPlS2CZv
	 F1Hh97clDsmFEKBoGsoMMLBq1SHcjOlSK4wDLn2gvqxRy7iSDuNJbx6TDYnFpMHfNm
	 HojIJXcd1EfPRd0hQhN1Q8F7wdlk0qqlnpyqLWFkOZ/fHuce8ykrqTVahPqjqlz5w7
	 vwqt985cAFMeRIR210BLfxwLhpzj3sXHkCUpDcbTEuw4YzMtVLzxxMtlaODgy2LjZz
	 FSOXPc5ixQIX9M10Cxt4gS5VyBdbsUyjWwFBoIWbEEHiiifMRDfdo05B/pwFzVUwBb
	 1B9YAFhi1faOg==
Subject: Re: [PATCH net-next 08/10] ice: simplify ice_pf_state_is_nominal()
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, marcin.szycik@intel.com,
 jacob.e.keller@intel.com, przemyslaw.korba@intel.com, xiongwm2026@163.com,
 ynorov@nvidia.com, horms@kernel.org
Date: Fri, 02 Oct 2026 20:03:24 +0000
Message-ID: <179097140485.434549.3177968248582768591@kernel.org>
In-Reply-To: <20260929224153.1455466-9-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-9-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "ice: simplify ice_pf_state_is_nominal()"
  names the wrong helper.

--

ice: simplify ice_pf_state_is_nominal()

This commit changes ice_pf_state_is_nominal() so it no longer builds a
temporary mask on the stack and calls bitmap_intersects(). It now calls
bitmap_empty() on the first ICE_STATE_NOMINAL_CHECK_BITS of pf->state.

> The function creates a temporary mask on stack just to check that
> first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using
> the ice_pf_state_is_nominal().

[Severity: Low]
This isn't a bug, but should this say bitmap_empty() instead of
ice_pf_state_is_nominal()? As written, the sentence names the function
being changed.

The helper the patch adds in ice_pf_state_is_nominal() is:

	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);

Would "Simplify it by using bitmap_empty()" be the intended wording?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929224153.1455466-1-anthony.l.nguyen%40intel.com
