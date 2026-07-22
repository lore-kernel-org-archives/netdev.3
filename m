Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0969481643;
	Wed, 22 Jul 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710257; cv=none; b=jYLUgO7Ue+G0/l33NrRFGo/qmpDlRIZeY5aKbvJy9CAuemMfxBvmEdouGbNaWux9MdbTqx0Zf1kMZeF/ndbeYE8UUMURowUIm75Mugekh6x8RHEXxVeJUlfNNxdpwCHJZq5YNYfqfhl0EknT6ZeN8cCgvjJjmm9gqZDpg6BNzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710257; c=relaxed/simple;
	bh=Rm5qSjID/LV60+jZ7tIslFHwoQHVYWmWL4euqAJ+CSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTe0DvIG1c1axdxLo4Oe1DRWG8UZNPhWuvOQ5Mb7SEQ1sgSkm59ftFxUd7riqZy+cwuzcyHI+OcTOBbHc65YrLGCNWFMsV8+WmUti3LJ12hdPfyQOZezOxiXuE398RH87W312PdBDRGbJ5hY8yVXCBdf5ds/rNzwQqiYLJIqBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCwxN9Bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCwxN9Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F11F000E9;
	Wed, 22 Jul 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710256;
	bh=veWhKVRSZSw//5Vuyt0wHt/WGWQcFCdhHgvHyXxpLo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCwxN9BqB65ruMxtLIBvCK5los7BSCZGaU4836oOHZTs9vlbduVkVAGQEVHSCfV6x
	 7ETIQIpDpsQMyaC4CwsGGIzOlFcZxM+CCC5aQQKuBB6lJfFVlk0Vgstvlb9b3iaRnD
	 XMnxV5JWQK0eKyK9ug8m0jR+hL1RbfbtqWpY3YvQ/xF/NkivuM6C/Yp5PN+A1zhWdv
	 j3Sbs4YBactAT5FsB77PcwZvXMtdveyAhN2FO1xjBKyskkyXYeHW8lQOb8+9zdRM1n
	 6VFjMXo1FTRDUzn9l+5IEzYuQlAh7eroy5eZ9tcaINWwiB4oc/uqXZzepPYSEIv3+K
	 lI3jEIDlFuXoQ==
Date: Wed, 22 Jul 2026 09:50:52 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v45 7/7] wrap pchan->chan_in_use  in READ/WRITE_ONCE
Message-ID: <20260722-kickass-porpoise-of-glee-d8cc7d@sudeepholla>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-8-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721175258.87600-8-admiyo@os.amperecomputing.com>

On Tue, Jul 21, 2026 at 01:52:56PM -0400, Adam Young wrote:
> read/write happening from both userspace and Hard IRQ context
> chan_in_use is used a flag to sychronize access.  Volitile
> semantics ensure we don't have a reordering that accidentally
> provide dual access.
>

With much better description [1]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20260717075649.467172-4-sudeep.holla@kernel.org
