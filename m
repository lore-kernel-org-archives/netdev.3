Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAF477285;
	Mon, 14 Sep 2026 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395321; cv=none; b=kNv+BvSGYNIIQtb2SNl4ulrqlYOm/IK6CR5HhR7RifqhLD2BiEaTMTpIbxop+VVeAs/0iKOD9hUPBJiz0qteWWX4JUNCeysp9YJt32BbNvbw33d4R5co3D4VgFtFgVCuTl9ckYlUaAfWYV1kcjyg7KILSEwy68N94qmB7AN/xSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395321; c=relaxed/simple;
	bh=pJEP2jXx/kpBZlMac24DIwZvoEWbE2RpgZUWbZeuRkY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=adz8XBneZFijO8w4tTYoKcf3QpxjMi0+clc++CzrDePA4Vb6zQzlvAUuO5q+HzGTFli6WAOdinh31TdNNN3XnSv9YYGekgS3gS2ZGjU3/Q5lzDDthFjzpAH+zmQaWCOlncE/hG6tQOf+zmRkRuaZEvk3HxrDZVfkTl4ZJi2H/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=fI8WJinF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="fI8WJinF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADEB4A91DB;
	Mon, 14 Sep 2026 16:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395316; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oQqj8734yTIB2BG9sV+cjhkAa7p+eZ136ESqc566fjw=;
	b=fI8WJinF145yi/CHJaIeLTbAaz+1JYizj/oUZcV5na+7Ii9Bu9OdPRmz4kll6GkawfXSz/
	VD78dlWIvB9cW8WWgst/HzGrvfwGKFPLpfZqacszUwmXTA9VnddXgcOmWzjR9ca93ZjMda
	T34vxQHFxVdEAv2JllC1S9jYGH1y2bLHNSeX93QXbWzEjT3ZsI6qTvii7hiZNV9EYwT7Zz
	Ck+GJEvH2L5hx4yF9sSCwbLnFJl1P7tl0kcfpTBIe3W3pBt6v9/Esx9RgOfxcXDhGGVhmc
	KQPe7vOeGYTh9PylTwz9xrKBNDUvgLc9unHBQshU0JlKWore8H4rRoJuEFLbhA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:15:16 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 04/15] ax88179_178a: Split driver into
 library and device specific code
In-Reply-To: <20260914-ax88179a-v11-4-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-4-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <ac99b74f58afc8a8162e740c50276cf3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.9.2026 14:46, Birger Koblitz wrote:
> Split the ax88179_178a module code into code common to the
> AX88179/178a/179a and 279 family of controllers and device
> specific code for the currently supported devices based
> on the AX88179 and AX88178a.
> 
> Rename the module to ax88179 to reflect the broader scope of
> controllers supported by the module.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
