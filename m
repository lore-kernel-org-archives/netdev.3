Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8323630B0;
	Sat, 10 Oct 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618148; cv=none; b=c4DNrdvD3MQ330KiYzFehG2JV2ROwzOYiCDDZZ1FP230+v9NbmxRBKaKxec3zzr9UJsUMFgIKq61NDrF/ErGzBBm/zTMP12C/g925JkRD8uvPjlfngETy5QUOdl+bI5ZUEvrzGcGndHNlXTEYexuvB+GJkju6cQVPP6w9Egb4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618148; c=relaxed/simple;
	bh=HyPzLRrcfBl0mgmNZFfi4VrIJ6h/dbpeSnbAwwMj8IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGSp6Lh+su2zr8OID8U6VuhZKGZo0IqvFC25xDXgfGklHZyKanPs5iGPNpdWQUHssnzgLj6Z8HV6zWb2Esr5q8nhxn4y4CAtFOsEVczstAJ2V/bcphrmKw+UboOXcq2wAAeSbXcM4CJy9xVfWWBarrzgX/simPsFpOduozRgcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=IY064Okc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EFRD9wLJ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="IY064Okc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EFRD9wLJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791618144;
	bh=HyPzLRrcfBl0mgmNZFfi4VrIJ6h/dbpeSnbAwwMj8IA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IY064Okcd6oNl1Fd5CEy+Ib8faOHVjBIq2liOAAbVv634wfGqs20ayyYLZgJtR/LQ
	 BKQggsKa+wh8uTZWTnPNfUdKCl3VF0+kOYnw7rS6WSG+4AEugJvcKeEq+XA0SGL8ar
	 kXt2x1aHD3gbGZuaRfVFVMaQ5uI9LBe9gPSZhSGP5c2hVk/qYbG8DTNSXhfrNZY8FH
	 t21+CShhRqqhl1BWX6qNjYbeAp7JoaCkf+4RB34JabFr9NzFdSSUNVIykqwA9ReWlE
	 X+rJs8Og49TiHrYQPt10J5UDseSxOmBYsLML/aVdIxy3Vgzfw/GiNibtTlWggAoXGR
	 d9kimNOIJyMOA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 65E7147553; Sat, 10 Oct 2026 07:42:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791618142;
	bh=HyPzLRrcfBl0mgmNZFfi4VrIJ6h/dbpeSnbAwwMj8IA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFRD9wLJqcM9O01zWVwavk9+j8Znt8KrFOWxcpNjF7m51NG6E42HPH4jVPkW/9JIx
	 irrUWZEKkbX7oZfm7/M/RTRUJyn3MLG9aYAwcAcp4RhBBe6T8UFvaUd83pU+4GrR9f
	 O8AFar8kfQAP5NXuNxDYIRE/d353a7KwjA6w6iSkwDpP736KfBUrxAfsqu/ROOO1Yd
	 tXMikRvaH9T68v5CEuPx+mQpxwZJ/YVNN7z4HqRxPzQBwU54ts+q4Q9fRR69t6Suji
	 MKmIOrszKHWRZTrchSEMVRx1rR7tZdH9RN+Xqw+fNQ+OjWMiKbXALlxVl8nPVqBKSZ
	 XhcmvvDXyYYyg==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C398F4752E;
	Sat, 10 Oct 2026 07:42:21 +0000 (UTC)
Message-ID: <ec24f075-e38d-44cc-91d2-16ff6305405c@birger-koblitz.de>
Date: Sat, 10 Oct 2026 09:42:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 0/13] ax88179_178a: Add support for AX88179A-based
 chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, chenhuacai@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, hkallweit1@gmail.com,
 kernel@xen0n.name, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux@armlinux.org.uk, loongarch@lists.linux.dev,
 nb@tipi-net.de, netdev@vger.kernel.org, pabeni@redhat.com
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
 <20261010062047.399148-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261010062047.399148-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jianhui,

thanks again for your persistent testing efforts!

Cheers,
   Birger

On 10/10/2026 8:20 am, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested the v19 series on my AX88179B adapter, rerunning all the
> previously described tests.
> 
> The previously observed VLAN-filter failure did not reproduce, and no
> carrier or RX failures were observed in the test. No confirmed driver
> regressions were found in the tested scenarios.
> 
> Tested-by: Jianhui Xu <neuromoments@gmail.com>
> 
> Thanks,
> Jianhui

