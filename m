Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146806;
	b=1+mMMDdnI7lMftCcYyEyN3ILky1vlrMrwTWhBmcg10w5xJtG0sNxekqQJ0sbvSJEzex0
	 PiQady/fd3kvXsIAjb1LIbx0BDZUB+raxBUXwZCIq4jgH5uIYfX7B2AkdwKx+KaThpnwy
	 Dhzeeji7jquoNquaK9E21naOLItYQW+gKtocEg4OD9aGT8Qk8XAOKan6+kwMWziP2IRFV
	 yhIA6y6ZvMzWLVUhGuRD3jjMGPqRCln/D4SjAdqYRAAdYMR8YKoJq2ZIl+vl2vDIZp6Pp
	 Ru1XyxGTV3DdGxCeDTflD+aGXgA85BFM3iHoavtezReYwNAplmN/efpWV8TPJYVZgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146806;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CKqvphMgjr/QNuebPWa6HLZr3WLoXlzpW/YvgjEUBqY=;
	b=J7XvmMYCi3A/2KL5+lOziG9fBUlUYqOP70WYXeJptIt3vlHifCZ1Z+k+01b5zw+UnN3u
	 XLOAmSszy9VxhCEKjyct4KJ5MrrDXLqF/ea+VQR5Lq8v7JGs4zDSgXFCywW3ryf/6CRvI
	 KAB4RrzZw0mkiDFAtr0MTAWzPa3fj82rBo9rgGgW6uN1kg+YNXOK9hzpF41C4N34IJwCJ
	 NaHJCJBpIz30u5oHcuI4N8NCP76kf5x159R2lPh5SVVoOxy7u0nXOdWOV/2CE1IekG7Jx
	 WLRgrwgsRZTltOSkCm0gOfe3xXiKkIOkG7DG4Aks91L+wjXVzF5CU/uIDTza/lElYLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TOHaDMWO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF8606A330;
	Sun,  8 Nov 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TOHaDMWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA871F008BD;
	Sun,  8 Nov 2026 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794146805;
	bh=CKqvphMgjr/QNuebPWa6HLZr3WLoXlzpW/YvgjEUBqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TOHaDMWOQ0FCB7WkU5FLy1od8vFY6BgoDsmPLCrr7Z4DEzi7wxeKW5bmH6cx/36xd
	 5CHEBu+9kTDwVFtTx/ZgvOrqKnyUQqrAm99xC86VA84wyjfolW9+AypyuhvUMin9ai
	 OYZz/C5wUGLMB6nog9zy7VK17im2ACxnuP7XdKAo=
Date: Sun, 8 Nov 2026 09:06:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 2/2] net sysfs: simplify creating empty wireless
 directory
Message-ID: <2026110816-crate-tightly-8560@gregkh>
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
 <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
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
In-Reply-To: <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>

On Sun, Nov 08, 2026 at 02:46:03PM +0100, Heiner Kallweit wrote:
> Now that an empty directory can be created with attrs being NULL,
> make use of this new functionality and remove the dummy attribute list.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  net/core/net-sysfs.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 5c0402389c6..f58b59e1126 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -910,13 +910,8 @@ static const struct attribute_group netstat_group = {
>  	.attrs  = netstat_attrs,
>  };
>  
> -static struct attribute *wireless_attrs[] = {
> -	NULL
> -};
> -
>  static const struct attribute_group wireless_group = {
>  	.name = "wireless",
> -	.attrs = wireless_attrs,

Why does this want to create an empty directory?  Surely you aren't
adding attributes later to it, right?  If so, that's not ok either...

thanks,

greg k-h
