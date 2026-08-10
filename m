Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9283F8EA1;
	Mon, 10 Aug 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373617; cv=none; b=GKuZLaTOGtS0mWyLvNzJmddP8iGQtT0oeO09NMKReRQJFFPw02JJMB7oDV7Ypy9IGJnXxMYwsv2rgL5htgAzOdybj0J4+z5undhaYg71NeG85uaVsUIybZvmHuGd6EgfRREPUjw9OLV3vjNKm9dYoSdhetC/4MTtlZpMvyS5SJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373617; c=relaxed/simple;
	bh=8ie/svVx6BlTReQAD18sZDR+ullo/yhfZgwAGgWLljY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC+QspaJVxgDz9eg0T4c6CwjUrEen8OIJlcu9GkQ2G5X73jTIBovRczjKZZj890+984pNUCJS74fboeu1cDWt28gURfOtZ4a/FxH64I7NC00N2IwhPt9LiaqpbKF+aan/ZgsRLEV5kWOVFQ3YOdCiIor8ihK//NBDA4vnqJWmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ttXDyUDO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ttXDyUDO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rj9SmrX4LFXbsuSfNCOqMSaoPpxDx1m++9WZt8HLaMc=; b=ttXDyUDOP2T1styE0D747jZdrM
	XH+PANfL8De7ho/3CN7AISYFjvXlZZA3P984SCUTlnFrOj3DbeMDl/O7UdLLPOg3pUyxJNp3sHjk/
	u4QsPnDJeLmSZ6iD82JuiNMlQf0n0WS1uH/SLHTGMtOQX1wW4E5HmOnUZwOK1gLVTr8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtRNd-00GwVg-QY; Mon, 10 Aug 2026 16:53:33 +0200
Date: Mon, 10 Aug 2026 16:53:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
Message-ID: <caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>
References: <20260810143740.652804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810143740.652804-1-ansuelsmth@gmail.com>

On Mon, Aug 10, 2026 at 04:37:05PM +0200, Christian Marangi wrote:
> List all the files of the QCA8K DSA Switch driver and add myself as
> maintainer.

Hi Christian

We normally target net for such patches, since users wanting to
contact Maintainers are often using older kernels.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
