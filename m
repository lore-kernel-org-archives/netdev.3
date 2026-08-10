Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0C3B42E3
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355854; cv=none; b=Bsm6WncdDgwBr4u0EKGdZF4YMjuDCDhwjljuoPuftCKlnaFlNTA87IlM9lPJzStBshdYSPzB0F81HlmPMEY5H97NKMegvO926fxNTjnP5FN9U+BlJ6Xgs8NKQJlh5JRcYbr1Ju7nidfvNZU/54fqwBhkmbXNPHjpleyt6IAi0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355854; c=relaxed/simple;
	bh=E+8Pgk5S0Fqz5C5f5AdPidzUS6Xx1d2jFJCwBF+skhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdsCcjOMlGOD1s6n9FW8VQgPwu7xbYn6pWHzfAu1EO78r45LIU3nuBKt9wjlAYRLlDGbsJUVsN3NHRIWqJVsfUIiSN7P7xdzaJy1sx+HvsVVVrlwPYANWrntifjzE+Itryqb7U6HxfwlZqw/U5w2L+aj1VH+955w0Knp+ECIK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/rhad/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/rhad/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DD61F000E9;
	Mon, 10 Aug 2026 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786355852;
	bh=KFvxri/LDQi9OgVtpNYWGk93NwcOPwTPoiDyWP3EJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/rhad/QEwuEHbFWpOj6ilikdkndTjzK33GoJYXdiUcFbIk7zAvS6zSywarSbiYpA
	 Zku87h4a6jz6Loc+Y3ws8ar1jG5d9Ble/Z+N4ONCjJPjh4wfjfXsGbNSXMYQzLvhJy
	 f89JnNiGV7ilVaqzwy586KVUAhBUUJ/uSwiCSEHyOIuXeMv3AjMpQiMb5HfyCtkXDZ
	 Dmc16yqbqYlcedHHEB0sbnQ+b1UmYo1Pbk7JQm5lacQmQYrmga3iojkAyhPTD8TUOj
	 9IMHpExufZHaZsTn9hBFimmGwU1yuUuNE9oXOOQZuo8lo21lrSXGenQ0VkZBnhhVW5
	 aknkQrevpppVA==
Date: Mon, 10 Aug 2026 10:57:28 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Czapnik <lukasz.czapnik@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jakub Kaminski <jakub.kaminski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: Fix "Unknown bps" during link events
Message-ID: <20260810095728.GP51943@horms.kernel.org>
References: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806162458.2384818-1-lukasz.czapnik@intel.com>

On Thu, Aug 06, 2026 at 06:24:58PM +0200, Lukasz Czapnik wrote:
> From: Jakub Kaminski <jakub.kaminski@intel.com>
> 
> The driver may display "NIC Link is up Unknown bps" messages during
> link state changes. This occurs when link status and link speed are
> read from different points in time.
> 
> The driver processes link events by receiving an asynchronous ARQ event
> from firmware containing link_up and link_speed values, then performing
> a synchronous AQ query via ice_update_link_info() which overwrites the
> phy.link_info structure, and finally calling ice_link_event() with a
> link_speed parameter while ice_print_link_msg() read link_speed from
> phy.link_info directly.
> 
> ice_print_link_msg() always read link_speed from the phy.link_info
> structure. This caused link status from the ARQ event to be combined
> with link_speed from the later AQ query, mixing information from two
> different points in time. When firmware state changed between these
> moments, inconsistent messages like "Link is up Unknown bps" appeared.
> 
> Add a link_speed parameter to ice_print_link_msg() to ensure link
> status and speed are always taken from the same source and point in
> time.
> 

Hi Lukasz,

Probably this can be addressed when the patch applied.
But I'll point out that git am will truncate the patch description
at this point due to the immediately following scissors ("---").

IOW, Fixes and the other tags should probably appear exactly here.
With the v2 information left below the scissors.

> ---
> 
> v2:
> Remove conditional assignement of local var link_up only during
> UP events. Cache state of both link_up and link_speed for every event.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> 
> Fixes: c2a23e00613b ("ice: Refactor link event flow")
> Signed-off-by: Jakub Kaminski <jakub.kaminski@intel.com>
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Tomasz Lichwala <tomasz.lichwala@intel.com>

...
