Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF503A6F04;
	Mon, 24 Aug 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559333; cv=none; b=ZtEK9JWaenjSZgHNo/8R8CDWrhk5YxFuhnw1kv61Ju3SSWmzMIXw1wQVwXdGfNfkAbwN6iEfoqmRq9flovF1kp/wdOVzKQ7GTRnsD3LLR1nDXpUwyrxgnuhtrUWYuoYt0m5jjJFApIQEFHNWy6qVw2id4+fgxv6bVPzZzsGVFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559333; c=relaxed/simple;
	bh=wy7nh93XzmdOkki7VcWgIRXqpoW4vZH9A63Z5YxUwuA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oCr+/XHB2zxSxeIFi2IROPXbSGE0k681ezBuZiasOHifiRz9y+VuwJiOdmnjOco+CqcpcXIcS0yholU22+/YnTeSI9b5Hvj21niWPm0AHCrDZSgTgTQyYv7EyMAesUbtwjM18/S9mY7Xo1zrjTX8K6E0ZUqdEuI2GCIpkPxBJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MNiT/gGp; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MNiT/gGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787559319; x=1788164119; i=markus.elfring@web.de;
	bh=wy7nh93XzmdOkki7VcWgIRXqpoW4vZH9A63Z5YxUwuA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MNiT/gGpprid9dQmbLsq/JixkQSElE8PHLaFdQYO8u4pJ3aFuQIgRbiMhRy10StT
	 pTsBI8DmmEZgybSh8aPq/59Frl2Bl7YcRIaFm8yFONAAkWlGz22MCisskcKpqqnPH
	 JS/tFh91jsg1QYuwZbhOyN6ibHMMLedsO1knqQtUZy7y4SzVkls0v+yya8uUn8meE
	 2feN70+Ry7kWDKpVm1bpqcUwHsyhsOdmYwWXhdA4tbJ/6GY5j78M2JU5Dn9kOnMs3
	 tUOTKhzB9TNn/AzS06IK942Ky3YCiJYHP7GBGyhnCAQrfAglqVRfbrOHe4HfmqQqm
	 jkdgv25IdF5F2xjBjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1xQbq336AD-00L7lp; Mon, 24
 Aug 2026 10:15:18 +0200
Message-ID: <92de3894-3511-4f13-950f-60b3f6911504@web.de>
Date: Mon, 24 Aug 2026 10:15:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: manushprajwal555@gmail.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Michael Dege <michael.dege@renesas.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <6a882352.ee10049a.267d65.7a31@mx.google.com>
Subject: Re: [PATCH v4] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6a882352.ee10049a.267d65.7a31@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ppxxs2Yj40wY+L7m8+0noB9MnLPixkj9NNDBSP8PaH205z3nvkD
 46gM6yluAaLinjAFVJbCxf7Kmp5BFhB+Xvc3nw9uQv/DCK6TcyWel0QS2UYMoUxb/EpCF64
 7QdNTVQ3t7XEa8U3K6uYx6eUlo4tHsJVXgGZvmCmBFXzC9PdloYFWmpRvCyyKYl297W00Cy
 nKhAmUxCZsQqq/xWAWspg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T63+d1ZiJe0=;dSH6EvUsc/9xJ7hlBo8eP57b809
 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

=E2=80=A6
> Rework the function around for_each_available_child_of_node_scoped()
> instead of adding a manual of_node_put(), so the iterator's reference
> is dropped automatically on every exit path. Since port is the
> function's return value, take an explicit reference with of_node_get()
> on the match before breaking out of the loop.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dri=
vers/net/ethernet/renesas/rswitch_main.c?h=3Dv7.2


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/maintainer-netdev.rst?id=3Dv7.2#n3

Regards,
Markus
