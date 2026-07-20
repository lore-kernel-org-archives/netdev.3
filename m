Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9541F5C2
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552490; cv=none; b=WS7Bu6NOFl6osgp4n6N2KidcioW5u6k02D58UIZLa/ptaUsBfjhXybuL3LcktKq8qwTJvYlW0PEurjT0V/PSw1uz9FXZ/NheMrOXf62lGZ3xTLfdK1tVHSUefKt1jP4ZIuK9Xtl1JQGJF5i234SaWdzT2BN6ti7I07oovzOvqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552490; c=relaxed/simple;
	bh=ZwQWk2WP9mjoSrfQjXgF8dASbDwrkagioI2bo1DeRgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpjZ5xm81gPbStYMVS+xhNJ70Fzyg22fo7YFNlc6obEwvD3jbnLXExH7Lv6u0CC2+m2DWktptc/4gDLXMeAtD8PyJubh9CCnBtLi0aOKHLixTO1VyB9acFjhXeQR8F/t1HvII6gnrogYH9t9iTrjCSmHY+QeTZts9n26+gv35Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=CeRdvc5r; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="CeRdvc5r"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485b358552so10796171b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784552485; x=1785157285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTgYWUe3WXyckpxYsQfWmNHOJqSUVnZMY1AjRMMIZDc=;
        b=CeRdvc5reR8qXpUaIl+2SlbsH/kRcBNQOFqhWjBDob6CmtXFiRk5t50YHIB0uOO6cw
         i37kz7z7Ar8p5w6me3ZlDgsDlY6iu7LdOp5Ow+Dq4m33z1OMCpkmmiqKN0TLpdyqLCNb
         qO9OamHl6vLquj25zgLst8E6im1Z1xMcwBDDlOSmxFhN1j7XRoWWLdZNIUW27IVULzds
         bJ76PgpuVlpo3Nu1FXz7A2C3C9jeQHM2ty/+hglbd9RaLvQ+atQYt4TRHjf+LxyDKMZy
         JqY75zYcibdYLiTDoxqJ0s+An6MpDVKgfXjrUhVcS+vsD/XashNPbkWqLGXADgjmWeWV
         Xhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784552485; x=1785157285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zTgYWUe3WXyckpxYsQfWmNHOJqSUVnZMY1AjRMMIZDc=;
        b=hiF3d6J7e2WJ6+Kjnifud7bmCH2WvtCf/MpxXNOQdWOxHsLh7N3LaYlYIaGCXi6koP
         iXvbUK3ZSIg4Gwa320AIXnX17UdcMO/CGo8+Cm5VafKUlk0Ny3rPId8GJQIkiYIJcYyN
         vTpwurLy5t9FwitOBxaaYCBF5M+W+ceUdy3D9ImBdCuUhTozUrD+t3Hv+KNEAuTJD4Cw
         zVIBG/YsHZtuWU18xO13jh3bYYWRu73JtHb7IPfgGbxdiE3aND9kHXb0lOkIvavEIdKV
         gljOAkSL7OVTtY/m2MaDm+w5fxnc3wRR3KKoU/eQj/RdOufeetTSbMo/JeGoCU5P3Yn5
         qWgA==
X-Forwarded-Encrypted: i=1; AHgh+RpaFiA29nQURfcibgTzOdKDnvs++P4Z32s/PZSf7G0DfJ/cmxppsSmCtXhUqUsqaK2QyWgDVIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9MA3WM74Ucv9HM/BCZCntgP9Dv/Flc7eGxhKPnLxH2MAMc8sx
	bURVAb9hBnCHE4oheiSCWtKQ1f5r9upRjkJCkFBwdQFV9m1Bc4qnYznGk103ixXnhTo=
X-Gm-Gg: AfdE7ck0pDEGqeIQvvUTXxMo2JzBBP0Vcjbx2xwDN3jIQR/qGkLdRt910irjnZ3T0Kc
	Pa3gW6HndJpgGCkPO/SDJqK49l8YDtXUVN3hQsbvKoFOGQtBZA9wuQ3XLklojPYVu5rtfsAW/oO
	b+TSEGdbmGY+WABfJUMPbDdssYSZHm0W2YB/Q5JeeGJLP/hi0sA4ujkPIXl4nzcvH9Jy0PBZE9K
	ESvLDWlfC6IEZvngGuGsIb9/Up/uarq2BJI8GVHcnz8aSKyJ6yF4doyNBmrdTNktbQSBglF7C5B
	2mzSch16lNVSV8mOlWzrqjuCpY+1wxcZbAFXeCm+lwk676FF6iBJ96bqxqojPGtQFADjIUqRnsa
	IqGPL44YCbUZb1fV0QMc09HpULKLi45b9CYDbvJZfiujpDFyXTtEFbv3ac/zR1k7qiWZ8
X-Received: by 2002:a05:6a00:a241:b0:848:4f04:87ed with SMTP id d2e1a72fcca58-84c292ca2a8mr13863684b3a.34.1784552484872;
        Mon, 20 Jul 2026 06:01:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfd0sm5649075b3a.25.2026.07.20.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:01:22 -0700 (PDT)
Date: Mon, 20 Jul 2026 06:01:21 -0700
From: Joe Damato <joe@dama.to>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: cai.huoqing@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] hinic: fix leak of ethtool RSS user configuration
 buffers
Message-ID: <al4cIYk8hEulreoI@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chenguang Zhao <chenguang.zhao@linux.dev>, cai.huoqing@linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260720091102.1653378-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720091102.1653378-1-chenguang.zhao@linux.dev>

On Mon, Jul 20, 2026 at 05:11:02PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> rss_indir_user and rss_hkey_user are allocated in __set_rss_rxfh() when
> the user configures RSS via ethtool, but hinic_remove() never frees them.
> free_netdev() only releases the nic_dev structure itself, so the separately
> allocated buffers are leaked on driver unload.
> 
> Free both buffers in hinic_remove() after unregister_netdev().
> 
> Fixes: 4fdc51bb4e92 ("hinic: add support for rss parameters with ethtool")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
> index 42f4792d255b..7d9c46004bcd 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
> @@ -1433,6 +1433,9 @@ static void hinic_remove(struct pci_dev *pdev)
>  
>  	hinic_free_intr_coalesce(nic_dev);
>  
> +	kfree(nic_dev->rss_indir_user);
> +	kfree(nic_dev->rss_hkey_user);
> +

I scanned the code and ... maybe I got this wrong ... but it looks like
nothing actually uses these fields?

If you look at hinic_ethtool.c, the buffers are allocated, data is copied into
them and then they are never used. hinic_get_rxfh seems to read the state
directly from the device ?

I wonder if the correct fix is to drop the buffers and the memcpys entirely
because they seem unnecessary and unused.
