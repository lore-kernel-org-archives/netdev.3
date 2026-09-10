Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39C3D16FD;
	Thu, 10 Sep 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044472; cv=none; b=EXo6dNPR9Ubh9ut8eR7wDqUYNYK4OrvmbuSRWAKNfTTyzypXRb/sO6QJPuRrSJkL4yqUXSRXxh/FQxtN7GAXwkZLbZVykEIdIW0cP7YP6Uhl2xwRUW0YIp6obczUVU5TSRhk2qbDQWCIWlVG1GgGwqlL7QIg8ecVO1IyxKIZUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044472; c=relaxed/simple;
	bh=XrEpGiXVeiwMS3iFogJDxxaP8k+IAOl/YZRlLx9MYYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6eEYHvkPXI3ymxRq8JkJ/Rr+ToTQsxSOXD0k8cfu5u8EvPtTsSMCC/ELLxAwDTY6kCwml7l1yeOBUy3QlcrUmrTJpoJrNITSp1tCRXKAQQ8HA0t09E4+HG+PX9L8Lvpbtt7MTovRKTtaAz+g7GqoqAMh8Bb9nEKoX3hwxo57jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Io2K2HJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Io2K2HJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66FB1F000FF;
	Thu, 10 Sep 2026 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789044470;
	bh=f489y3/cjqIMXi2Vm5eX0XSu0uZWkW9AoqmcNi3ETqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Io2K2HJ7altBOlDra2yUc8d4e4OmM8nzK/XIwWY5pNmjgb+sFk3ZzBfNoz0vk5Gct
	 wPMQkDCuCit/aOCzbTxRo3PZgHQMXTSrtAN/hsmcm6JpQOkiMzTpoMue6rgtFM7OwA
	 o0A14V+gt/w6d2QI52hHKZKR3R+L/nJsaCX3tGck=
Date: Thu, 10 Sep 2026 14:47:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jie Wang <jie.wang@intel.com>
Cc: Chas Williams <3chas3@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	accessrunner-general@lists.sourceforge.net,
	syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] usb: atm: cxacru: fix NULL deref of atm_dev on sysfs
 writes
Message-ID: <2026091012-nastiness-coveted-74e3@gregkh>
References: <f3ef0a67-79d7-47da-be6e-7e82d92e68fe@mail.kernel.org>
 <20260908150203.2119844-1-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908150203.2119844-1-jie.wang@intel.com>

On Tue, Sep 08, 2026 at 03:02:03PM +0000, Jie Wang wrote:
> The adsl_state and adsl_config sysfs attributes are created via
> dev_groups, so the driver core exposes them as soon as ->probe()
> returns. At that point instance->atm_dev can still be NULL:
> usbatm_heavy_init() only waits for the heavy-init kthread to start, not
> to finish, and instance->atm_dev is assigned later, in usbatm_atm_init().
> 
> A write to either attribute in that window passes the existing
> "instance == NULL" check and reaches atm_err()/atm_info() on the error
> path (and, for adsl_config, on the success path). Both expand to
> instance->atm_dev->number and dereference the NULL atm_dev.
> 
> Fix this by logging with usb_err()/usb_info() instead. They reference the
> USB interface device, which stays valid for the whole write, and
> usbatm_atm_init() already logs this way before atm_dev exists.
> 
> adsl_state_store() also calls cxacru_poll_status() directly, which
> dereferences atm_dev via atm_dev_signal_change() and atm_dev->link_rate.
> Return early from the poll when atm_dev is not yet set.
> 
> Fixes: e605c30977bb ("USB: atm: cxacru: convert to use dev_groups")
> Reported-by: syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9b195c4f412ea5c4e56a
> Tested-by: syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
> Signed-off-by: Jie Wang <jie.wang@intel.com>

Did you forget an assisted-by: tag?


> ---
> Changes since v1 [1]:
>  - v1 gated on ->atm_dev at handler entry, but that check is an
>    unsynchronized TOCTOU; remove the ->atm_dev dereference from these
>    paths instead.

Sashiko still has some objections:
	https://sashiko.dev/#/patchset/20260908150203.2119844-1-jie.wang@intel.com

