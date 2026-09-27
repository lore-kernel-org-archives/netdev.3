Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FC3CF95A;
	Sun, 27 Sep 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501859; cv=none; b=lEf1LuJs6CZOjp8Zz2PCJUyEEnR7tOafMjzYIB/qW4ki6HrnUhSMyCMhr+lBUg8tBrBWjfniSsr+QrvsVGyo5kGDaOKonytNxMaAdEE5PGOuHIq0D9esM0Oty6oJyYg1XF3RFFGc0+DVz4MDnb/u7NWQtbXDKRdFAGIrbm7h62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501859; c=relaxed/simple;
	bh=+ditpVy/e4/b/5Rvj55pmoM4ai18YaQDGmsGPisW5Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elpMHSMVhBD33+xNbzxdxrqA3aK9ym/vah72+/d2TcJZr/VRbqxLrxQDhEWI5p0z8AaDzPuuvmAIKkFALQPbpfEU7h7Cdgsz1O9EfnsG+tZfsz+3c6EQeYtssFswvXbbX4Ew+XolM7YYOpU6hxIPl9TsH212wMZdfu9s4xp+eN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QxXYzD91; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QxXYzD91; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QxXYzD91";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QxXYzD91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501853;
	bh=+ditpVy/e4/b/5Rvj55pmoM4ai18YaQDGmsGPisW5Xc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QxXYzD91r2WsgVxJU1k86F2yO01/noESfaPONkpusWBwa9R5Knymr3iLur/mj9Yc4
	 A3GBWZ3+9pUPDYE/rQT5SulVwWc38joxzgsYq5WfywMo5C7DzQCeotM31dSCTkiS11
	 wq49zFzpMossguYAKur9QJgsT/Nv1jHaGseuTr/VgLK9EOABeDijK69SnpMAJC0Xu+
	 u3PX9A5YxMqvOQOEaDG61PQcyPkYRQ5mDe6T0Yq2X+9VO4jUqGjC4dvzYL1LCxvUMg
	 lpU93sJxvEoUHOS/RcEgU9Q2x5/kxVK8PjJNt9WgsMleCuEW2cbPa6F5QcYF49bX26
	 M5HtMtk4RdN6w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D0A3241304; Sun, 27 Sep 2026 09:37:33 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501853;
	bh=+ditpVy/e4/b/5Rvj55pmoM4ai18YaQDGmsGPisW5Xc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QxXYzD91r2WsgVxJU1k86F2yO01/noESfaPONkpusWBwa9R5Knymr3iLur/mj9Yc4
	 A3GBWZ3+9pUPDYE/rQT5SulVwWc38joxzgsYq5WfywMo5C7DzQCeotM31dSCTkiS11
	 wq49zFzpMossguYAKur9QJgsT/Nv1jHaGseuTr/VgLK9EOABeDijK69SnpMAJC0Xu+
	 u3PX9A5YxMqvOQOEaDG61PQcyPkYRQ5mDe6T0Yq2X+9VO4jUqGjC4dvzYL1LCxvUMg
	 lpU93sJxvEoUHOS/RcEgU9Q2x5/kxVK8PjJNt9WgsMleCuEW2cbPa6F5QcYF49bX26
	 M5HtMtk4RdN6w==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 264C0412CD;
	Sun, 27 Sep 2026 09:37:33 +0000 (UTC)
Message-ID: <b27cc8f3-65c3-4178-9750-e8fe6a35fca0@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:37:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 12/15] ax88179_178a: Add ethtool get_drvinfo
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-12-60c04c9924a2@birger-koblitz.de>
 <178968030501.22033.322532364708711574@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030501.22033.322532364708711574@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
> 
> - [Low] ax88179a_get_drvinfo()
>    (drivers/net/usb/ax88179a_devices.c:221-233) formats the ethtool…
Will fix by reading the revision number into the 4th field.

> - [Low] When a bootloader-window read fails in ax88179a_bind()
>    (ax88179_read_cmd() < 0 at…
With the above patch, ethtool -i will report "255.255.255.255",
which should be easily identifiable as an error value.


