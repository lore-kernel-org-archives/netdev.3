Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098E2D592D
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773625; cv=none; b=PMCDM2+0yS/aGi1CKUIeirsYXJTvuU0oevtf6NWY522B3+QWMDYzxyIm5dfR9VKY4FinLSi0QPj6N8V1SMxwmKYRP8vdRkcN1oKGlMVK3DTL8gBBy2t+S27MWvDnvJt5F7EQk/Tan6Q1OlHDpgNF/I7FQ0nnNggmy56j6SEbBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773625; c=relaxed/simple;
	bh=Eimbm83VcnNh9iAyz4eSKXIS5dn85BJj6roRS8IzYgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYhJsxPTBbHSF9t4LNakpuCDa94tnb84jKCAo1OFZFYMpv1SSmKTdazNpEzCa9y6rf4Ckb50xTnIuuihx98evY8kQUppnIfF9mVw8kiZZyyO+i4+Lva8hM2yAq3EJzE6qMt5yhZDAqXf5Ms9IoHh4n7k8KvcszbczI6aMAuf9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLrLjUsm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLrLjUsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9011F000E9;
	Mon, 29 Jun 2026 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773624;
	bh=mQm2Cpdl7FUXTMgD3IZug5m2bpmaRdES+acA5DhlVW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cLrLjUsmPAx7ouea3DL7B/uiISyRyGu/yohUtSjZxm+ui87QxAUY07QcQjR5/9gQK
	 yZdMROLg5kPBQJhSdl4yqRvOfTgS+gBLjaJeZ5ER22d9U23qA9ZkSsR3fXohvIgTkW
	 isdMP3VY97vwVLQGF+uzHGwU5EDoJxZTedQL3THu2gb5hFquDeE5L7/hPG9mDpUy3p
	 If0rZpIHe3iJrMjpfu2RHcGFf0UW2G1fTJZphfhglXBsWb3DT6Hd2R/4lxJMCBQo4I
	 b8L2ejeIy8pSI20BTJ8CV9yH7TJdrk3bR8sBlMuUhZ41IuzP0orlrt0/VvA69SbZpD
	 yfZtthA7mbVXA==
Date: Mon, 29 Jun 2026 15:53:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash
 configuration
Message-ID: <20260629155343.7fed8291@kernel.org>
In-Reply-To: <IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
	<20260626054730.1126969-3-aleksandr.loktionov@intel.com>
	<20260626152636.1e48330f@kernel.org>
	<IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 14:10:08 +0000 Loktionov, Aleksandr wrote:
> I understood on TEID; I will drop the ethtool core patch.
> 
> One question before respinning the ice feature patch: ice GTP RSS profiles
> include TEID in the hardware hash fields. Since TEID is not generally
> symmetric across UL/DL, should the driver:
> 
>   1. report RXH_GTP_TEID honestly and let the core reject symmetric-xor
>      when GTP flow types are part of the preflight check;
> 
>   2. hide RXH_GTP_TEID while symmetric-xor is enabled, even though that
>      misrepresents the hardware hash input;
> 
>   3. reject symmetric-xor for configurations where GTP profiles include
>      TEID; or
> 
>   4. change/program the ice GTP profile, if possible, to exclude TEID
>      under symmetric-xor?
> 
> My preference is (1) or (3), but I do not want to encode the wrong uAPI
> semantics.

Do you have access to any GTP experts?
If your customers want the TEID in the symmetric hash then they
probably know better what makes sense than me after reading about it
for 1 minute.
We may just need a better commit message on the first patch "TEID is
intrinsically symmetric" is not true.
Or maybe the driver / profiles are not doing the right thing.
Please dig deeper.
