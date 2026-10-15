Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255713EDE6E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062345; cv=none; b=swCA8ND7Aj6CxFZR9dnqIWo+JWha0j7Sbh6eFBM6tV/aVegTvXd4nhrmxxUMVLwlBbkLtwbTKjwRD5LeCW+dJipR47xat6K9xFrbDoDqQlnKAgjaH62/yDf3/DQU2mMz2plMgPzByeEiTVJBJQku+cP5Zd9t0DQP/+Veg78we1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062345; c=relaxed/simple;
	bh=qym+Nej6oyhMta2vS88GxtdbWI9x+NtBotNnxLHLiag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6F++ox8smdFhD+xSm9ccikxILp9orhfSdv9GFbzcbHP//eUs6hu24+fW8rwV6sRp77sy1fqES5W+nExpH2y/YncKugG77U8pGstwQ6MQPvVVwPvw1QhCTYgxiOOmTjPHF4OVKnYKkUiQHJxgmJfn7owm/LVUY/f3CH+OrBGEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6LCn8t0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6LCn8t0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2F1F000C6;
	Thu, 15 Oct 2026 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062343;
	bh=gpSCGiwFK8jb1vIu0OazDdrhB4i9b6EHzc8RrbUAqCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l6LCn8t04D+Qv5obZrwkKu8P27FNKN0hPhMkk36APmayhUMkDhMmutsQ1Nc+PqAYX
	 psXMIXwulx7BOjShXFADnzt8VSBmuN0KbQ1iSrc6YZCgZybzayie/EcqHkV9GiF0h8
	 y7wy7ExO0/AmEtflGZjuML+Yxl0UyA3+sQIOqgJC4eMoyz9oxSwfC1QAqJjtmbeTxz
	 U/y7dSurYhkre+bADIq5VDkPZ0cEPDuzA05Jonj/42MASVqK1y9LqTlUMqYvQKRceJ
	 sohQpW+in6+g2CExeFNw+5Zg8lYkvEWK2AunJywm0LmJo1biuzOA+KTKIVI5yqfQvo
	 825RaNlz91EiA==
Date: Thu, 15 Oct 2026 12:05:37 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org, edumazet@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
	rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com,
	tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
	jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
	anzaki@gmail.com, brett.creeley@amd.com, jtornosm@redhat.com,
	ohartoov@nvidia.com
Subject: Re: [PATCH net-next v2 13/14] ice: represent RSS LUTs as devlink
 resources
Message-ID: <20261015110537.GF83879@horms.kernel.org>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-14-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009121433.30347-14-przemyslaw.kitszel@intel.com>

On Fri, Oct 09, 2026 at 02:04:24PM +0200, Przemek Kitszel wrote:
> E800 family offers three kinds of RSS LUTs: VSI LUT (sized 64), GLOBAL LUT
> (sized 512), and PF LUT (sized 2048). Until now the GLOBAL kind was not
> used at all. There are two possible usages for it, subsequent commit will
> give VF option to acquire it, and this one enables PF to switch between PF
> LUT and GLOBAL LUT - switching to smaller one is, again, to make it
> possible for VF to then acquire the former one.
> 
> Devlink resources are used to let user show current usage and change the
> allocation, see examples below.
> 
> Default state on 8-port card, asking for aggregate "whole device" usage,
> note that there are as many PF LUTs as there is PFs, and, for e810, there
> are 16 GLOBAL LUTs:
> $ devlink resource show devlink_index/11
> devlink_index/11:
>   name rss size 8 unit entry size_min 0 size_max 24 size_gran 1 dpipe_tables none
>     resources:
>       name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1 dpipe_tables none
>       name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1 dpipe_tables none
> 
> Now let's add GLOBAL LUT for a single PF (on one-port NIC):
> $ sudo devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
> And show it's resources after that:
> $ devlink resource show pci/0000:18:00.0
> pci/0000:18:00.0:
>   name rss size 2 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
>     resources:
>       name lut_512 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
>       name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
> Let's take the PF LUT out of that PF afterwards:
> $ sudo devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
> now `ethtool -x $ifacename` will report smaller RSS table.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Przemek,

With this patch applied the following errors show up for x86_64 W=1 builds
with gcc 16.2.1.

  .../resource.c:340:17: error: typename in expression
  .../resource.c:340:21: error: Expected ; at end of statement
  .../resource.c:340:21: error: got rel_err
  .../resource.c:340:17: error: undefined identifier 'int'
  .../resource.c:342:17: error: undefined identifier 'rel_err'
  .../resource.c:343:21: error: undefined identifier 'rel_err'
  .../resource.c:344:25: error: undefined identifier 'rel_err'
  .../resource.c:344:25: error: undefined identifier 'rel_err'
  .../resource.c:347:39: error: undefined identifier 'rel_err'

...

-- 
pw-bot: changes-requested
