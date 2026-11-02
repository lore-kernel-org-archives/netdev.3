Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620954;
	b=s1cQkgvxmwsikoVJyybHONHnT6fkIcsoRGpJFLoAFt+JwblNWaUy7ZxAuQXgIM0pGoGe
	 2LLSWUN7jlm6iy5OckjTpobIJNaGHQkq90zU+XULRW/73ETZS1mEZ3An4o+mPdLn7pWEu
	 oUKjs9spm7htErsSSmyt0b5ClVAi3NeTnhNuamqdeUD46HpzDtvgs9a3vY2yTcB1X9+5Q
	 3w/fC6hXUQznU06902pGcEgBMW24GZ5pryiXXVgJBJ7X4jaBSkN2mHr9MoDs4oI7usQ3v
	 tnSe977mjIMJOFD/FPnp8Qit4Cnlpo2eZbAfHWCm/mGgjsqlxOyi5TCV+ORV/qOT2sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620954;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fr0PNZ8uIjWuUyi5jHRttjfJcgJHs22wa+3cbgmTv6Y=;
	b=03B3Fo0FMxRxAuyztvg2VT5NLMTfaOV7YoPAe6TkYuvFoUDRxoDbCg3cjgCedpMfabuR
	 5YUwZFUHRglGlSyevl/Tz7GT5/6NmwiWtqbxqVafJOwoqIY1FQFNtPgDobDQrPgkCSFta
	 R2JCeGTbrkk756pl/kZTDf7d7bw+Cnv1Rt0CzCdcvxk+piYM/yxYeYJvL/l7Tm5wjIQmH
	 rd5PtznA/nA8ACbb+hpRdQjaerw/pWHxgebolYX2VlIitaXBYFP/0rNTR51aJ6Ou+MyDE
	 dBNpmOdeHb1QG/O/iMfR1TLqtTkxvYIh0a2m4aQNDlKv8UUdVCLIdA7RtTuBATNyJag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfYVxPB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E071606B147;
	Mon,  2 Nov 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfYVxPB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC701F00A1A;
	Mon,  2 Nov 2026 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620953;
	bh=Fr0PNZ8uIjWuUyi5jHRttjfJcgJHs22wa+3cbgmTv6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dfYVxPB9FUjwqMKzUEdki3dEUE+JjX6MW5u4ot6oLabApyiP1RviAtUeLvEP5pm6u
	 MPMpM/JZfubJfG5nvMPUo7oxtSxvXnyaBxH1JAytGEU1MzHjhlDT5sqXiX5qKA2F4/
	 K5KtA2DnKWSFNcCl3ALFAhmhU+4MPPUjHzB2A26ihsykZGkHGq2jtzUJvdL9umrjta
	 70PMnZM8vC8QoDil13KxnBIessCPw+qVfUOjd4fbnS8z8Yaf8C+SeICJBEzBjn9E62
	 2gSOri5oI1X4LuRN6e8u5anUFi1gE0+Vgxbg9zdBNBq2qn7dhQh8r7ybGoLO/WM4qG
	 6w4znKQSvSrHQ==
Date: Mon, 2 Nov 2026 12:02:30 +0000
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net 2/2] devlink: sb: do not dereference a missing shared
 buffer
Message-ID: <20261102120230.GC257209@horms.kernel.org>
References: <20261030033332.3685172-1-xiaolinkui@126.com>
 <20261030033332.3685172-3-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030033332.3685172-3-xiaolinkui@126.com>

On Fri, Oct 30, 2026 at 11:33:32AM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> devl_sb_unregister() looks the shared buffer up by index and only warns
> when it is not on the list. list_del() and kfree() are then called on the
> NULL result, so unregistering an index that was never registered, or
> unregistering the same index twice, turns the warning into a NULL pointer
> dereference. list is the first member of struct devlink_sb, so list_del()
> reads the next and prev pointers from address 0 before storing to them.
> 
> The register side already fails gracefully: devl_sb_register() returns
> -EEXIST when the index is taken. Make the unregister side symmetric and
> return after the warning.
> 
> Fixes: bf7974710a40 ("devlink: add shared buffer configuration")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

