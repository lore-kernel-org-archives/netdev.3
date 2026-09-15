Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E74ACC74;
	Tue, 15 Sep 2026 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509251; cv=none; b=BgPdWtGdJXWZjKpKnj0eanq1Jx7PdqIuvFWz4fAfTJ5aHAl+Zj2MUJliCv7iPN4hBv7ln/12woaELwKQgpfFmiUHzq753uTKIpauAMer7ijF5WxJWI7fbO3uyaCJezC7GqKGU4PjsY3CbXW1rt4H28FPjbOLQXPcROfuLnfk2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509251; c=relaxed/simple;
	bh=6S3VUdlVEwy3ga15e6e1RXZk0CbAEQ4qPP6XtPxov6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQRaipPmfZdTx18mtHlqsQ/kDBHf5jZ0mQMw+z8lh2q7/vSL1tLV3xCOAnYdYVA5hWJn6RQF3dppx7rE4dDTHVg0HTLL2MyyFc67bDlDBQMtTGqYX4ofYEi5RLQfDdNg7gFtNnlLqsLCLhPjGk9ZWcz3MbQZSDqYUrqf9ntriEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dAWKpdnQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dAWKpdnQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ge6MK62zqf77izaM2Sc1K+yt2h5XSuWH6iYpxNJbacw=; b=dAWKpdnQtzcCBw7EHyRDu9uuG3
	F/4/r1iVwVsFc2XAieWqUZIKbanJ2qyhvppwpIQObvS4wHqbavFaoRHSYWDN+4XlL5yQlbRgrJN6t
	3ZHa1raUG9IoTDqZjVRFOYehetoARNryP0j415CecqvCvq7wX1RtMaFlFnHnQGP3Umgg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6b6C-005LoH-3D; Tue, 15 Sep 2026 23:53:56 +0200
Date: Tue, 15 Sep 2026 23:53:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ch9200: do return USB errors from
 control_write()
Message-ID: <6a229f3d-db29-49bf-a53c-04ed56d9d967@lunn.ch>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915185805.38712-1-s.shtylyov@auroraos.dev>

On Tue, Sep 15, 2026 at 09:58:04PM +0300, Sergey Shtylyov wrote:
> Compared with control_read(), control_write() looks really strange:
> it ignores any errors returned by usb_control_msg(), always returning
> 0 instead, despite overriding a positive result of usb_control_msg()
> (indicating short transfer) to -EINVAL before doing that. Drop that
> dubious *return* and propagate USB errors to the callers...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
