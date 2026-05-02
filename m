Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B81531C8;
	Sat,  2 May 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777743116; cv=none; b=sHgrbP4X15iRDxdbu+ysvhMBKjWKdBCSXxHmMpr9aE+rtjOrXgWfAV/GQ7TSM2Mt3al6EwxVR2gaqqto+msP4oHBOpru8MIYhDGAOxKsCdQ+OIqzRSXC6nW9g/65BEsCpM9XMsxBrOBt04XQp6HRrDme3E8Wrp6Mz05Ci1aHj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777743116; c=relaxed/simple;
	bh=FO6nMcMn/OGU6uVS1myEZJa/Wri94sywk/kufi7znt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2JDDq749vq1NLP+L+/wTlIF5zf7mP3dQFLKQd9Iqay0sO5oR0FNWkRG4LiK6DCovD35KBFq8ZcR+aAx26WrRvwaOYvYCj9+5rGu4/NsASdYdtTu3Sh3Ae8g+Y37Y80PhmgiMC87RB7k6uRCYCbqQuRRv3nJSYymS3rrPY/3ZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGyfBsqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGyfBsqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406F3C19425;
	Sat,  2 May 2026 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777743116;
	bh=FO6nMcMn/OGU6uVS1myEZJa/Wri94sywk/kufi7znt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gGyfBsqb83MA8IoSJM0udPhNHy69AFryi5X9Dy1SpE2tZSuT/RBvrQY5Jn8npArWI
	 QP/NC9fNm24xkYgn8Bc05tSVeeZtoUka8ZdRvW18FspJFWxkn3seyZT4U0kYaR8CMJ
	 +gwG8EoHsCXuoxKx0lpsT5HE00uMHmF8H8RaJvBZBJC3tyXPNQ/d8PrXnWlwqyqNR8
	 DrSB6NndZGdyyaIZ5XhkoV5z9qHxyO3C3UNF63S9CkRQtWLcyYM6+rIFH1Bc7AFbV6
	 A5driE33UrVCc19Qicg/o0+tgPvcOtOV4Xg15JBzeO65GG693lGKrq+ayDHXa3uOjh
	 DxIDhfFia9WPg==
Date: Sat, 2 May 2026 10:31:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v7 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <20260502103154.71b4b5de@kernel.org>
In-Reply-To: <20260430094238.987976-4-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
	<20260430094238.987976-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 11:42:33 +0200 Grzegorz Nitka wrote:
> Subject: [PATCH v7 net-next 3/8] dpll: extend pin notifier and netlink events with notification source ID

As AI points out you're only adding this for the internal notification,
but the commit title mentions netlink too. If we don't need it in
netlink we can just drop the references in the commit msg?
