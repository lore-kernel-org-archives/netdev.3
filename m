Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF0385D97;
	Wed, 19 Aug 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149095; cv=none; b=Y+2Ka6tMMhXGkL7lTE+vq07GqCcMuBGfYTRf3t3WIXqrqvmh4oMoNmxWa/mKEIY+4VQvS5Ki5FJcl0EAB3qv5kP6bXr5cswS5e+sglsLmolY57E+Hs135wSIhF1ffBd9eD5TMGs1e71CC6mikjmL0MPyOcf2Vk8GXGXqSe5JSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149095; c=relaxed/simple;
	bh=KiX2RF+RZV4yShK0hXAxoYAUCeSX5eJu1olOk0e6qn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbtq6uLMAK+Gn5+pT8grktjx3z86J3XVETgJLMI84m6pCompD2aVo62MMmzQYLXvWySbO4BGPD0PgvyGjtTE7k3IaaA+5GUniZmg5gVydajsAd2kv+FJRmTUgaeWtCi3BvhIEG9G6nQuW1lqPEMmo3TPlckRJWY2gqjlcNIXgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv3OryoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv3OryoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7E51F000E9;
	Wed, 19 Aug 2026 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787149093;
	bh=LvbuGOrC0Hg0D64eNdP9PSDGg/aMc3jAbpv4AU4oxRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wv3OryoKzfv4FxmIn5+lVl6aDC4NgN6l5qkL7Rc0RTw8BXqKJsL9WzSvvcWkMe0wt
	 hH5TB99oog3V2R70QwWBFJf48rsBRkrL2ZRWG+IDW/OvTsCQZtQsoS6ckwz5QiQASD
	 8YpBP4oMR7oSEGRMRfXSM94941OLILYrFgd76Wd2OUujZZPUC7vQq6OcSlN7TaoYjy
	 zaE20Aa0SU3rGsfiK1ccET4rE4aj8gRwzeSXzZRkqtt7Q9I8xSW3q2v7gO31aAD11Y
	 BN8xtyoQH1GSohfiHQ6XV7cnnnZGXOwQY36c0z6QmmWGWgCxe1lGSYDzGDannRf26K
	 MEO6pHdTB2X5g==
Date: Wed, 19 Aug 2026 15:18:09 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: qlcnic: validate unified ROM sections before
 loading
Message-ID: <20260819141809.GS265046@horms.kernel.org>
References: <20260816052109.4607-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816052109.4607-1-pengpeng@iscas.ac.cn>

On Sun, Aug 16, 2026 at 01:21:09PM +0800, Pengpeng Hou wrote:
> The unified ROM parser reads directory, product, and data-descriptor fields
> from the firmware file.  Existing validation forms table and data ends with
> unchecked additions and multiplications.  Malformed values can wrap before
> they are compared with the firmware size.  The parser also dereferences
> typed pointers at firmware-controlled offsets.
> 
> Valid descriptor extents alone are insufficient for the consumers.  The
> loader reads a fixed-size bootloader regardless of its declared size, the
> version parser assumes a 17-byte tail, and a partial final firmware word is
> read as a full u64.  A truncated image can therefore make the driver read
> beyond the firmware allocation during validation or loading.
> 
> Replace the pointer-returning parser with bounded range helpers.  Validate
> table entry sizes, descriptor indices, section ranges, the fixed
> bootloader load length, and the version tail before exposing any section.
> Read all file fields with unaligned little-endian accessors and assemble a
> partial final word from only the bytes that remain.  Apply the same range
> checks to the legacy image before reading its fixed fields.
> 
> Fixes: af19b49152bd ("qlcnic: Qlogic ethernet driver for CNA devices")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - follow reverse-xmas-tree declaration order and drop unrelated whitespace
> - replace firmware structure casts with bounded unaligned reads
> - validate directory and data-table entry sizes and descriptor indices
> - require the bootloader section to cover the fixed load length
> - require the firmware section to contain the 17-byte version tail
> - avoid a full-u64 read for a partial final firmware word
> - validate fixed legacy-image fields before reading them
> 
> v1: https://lore.kernel.org/all/20260706093601.81535-1-pengpeng@iscas.ac.cn/
> 
> Validation:
> - scripts/checkpatch.pl --no-tree --strict: clean
> - git diff --check: clean
> - manual source-level audit of directory, product, descriptor, version, and
>   loader consumers

Thanks for the updates.
And for including information on your validation steps.

Reviewed-by: Simon Horman <horms@kernel.org>

