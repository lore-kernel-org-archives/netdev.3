Received: from send146.i.mail.ru (send146.i.mail.ru [89.221.237.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D95172D9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571726; cv=none; b=oSsKNTXktL8R2qQ5PJwf60YUXYtyQ0Ke4K5taZD+3Im4/gw/cVg8IuzQqkWDe4FQxMpbQ52f5cDWo0qV4oWVTh+ghwZ8kI5QQNZeaDTF3fTOnpDQh1NgjGCJU9flO/T0KxaDaNRHi4SCx/In4D6VgEpC21BlvMVEkxqMotqSJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571726; c=relaxed/simple;
	bh=P3iRQPVrj0y58gbjM8OjXeK7oC7/Qyx+z2Z5ICkvLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FvRNxBGzc6VNPlb+QXaYNLhaWShxqFO3WAzZgx5eyX1XkbK5fAvcDzxpNPSXNTgi84qgEq1AaKFwiVANjKhShEykuOIj2IhMlIM9qFLrXkjFogfoKE95Q19BvF+D9/igUlKYTm85rdSDv3nk3bWUVRJGetbSRhdMuuXHDjkZp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=oarsyTCj; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=ay6br0uW; arc=none smtp.client-ip=89.221.237.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="oarsyTCj";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="ay6br0uW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=P3iRQPVrj0y58gbjM8OjXeK7oC7/Qyx+z2Z5ICkvLKA=; t=1791571721; x=1791661721; 
	b=oarsyTCjuP/PP4OL7uuHGne5Db3DPBXTJKOx6zSFOav4FQkXLJVQhh0SMocU3hXph/Xnt2yUCtn
	OrBQXSxxD4eK6x2bCrqw0a1l7yngeYvjd9wYR1d9V/h5uuFvg24jryNOwRn9SybeCXBs1URROgSVf
	/oG2kHfTXuiehteacdddwuZXYxjp/Uf981xm0RTc/hfUhTyTLPCG5+YfCmuWUbXT4EZP5zzGeKOcE
	nLXZrCvNYf8mJYZ61aUWqn4+ewWbLxrnsBnyEcouVTYUtBNDImQ6CpuazueGnizGx3WJa9SQgu1u4
	R4XQIeFVIt9T0om10P3vO30HHOKvZto646ZQ==;
Received: from [10.113.21.85] (port=42696 helo=send83.i.mail.ru)
	by exim-fallback-canary-30-bf9b798b-hpm7c with esmtp (envelope-from <skyline@mail.ru>)
	id 1xFFPO-00000000KLv-0CsT
	for netdev@vger.kernel.org; Fri, 09 Oct 2026 21:33:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=P3iRQPVrj0y58gbjM8OjXeK7oC7/Qyx+z2Z5ICkvLKA=; t=1791570810; x=1791660810; 
	b=ay6br0uWeZweC+Gmpt5vk5Obfu9OX8XCNWrmLCBc4usy7RCOk3zx5ytgdPX1ZcAtXFjnTw5mtVh
	ZPLi00JKbpgtSjTbl9CTPhAHnUiD+3xlXRhM6yQBnMVvItgUSauQc/e2TOjcOj6mUZz/jyyvJEjZ3
	e/i/q+6u+hn4X4OGJloWosA1P0wSklH5RWUpK5P/VmW/Gl0c7j6qaFWZWGdKEn06+0EIzLs61nRQ9
	q9Aht2RSQ6loTCK4VIqA3klTsEJZUMCVgh0nQX80wGUhk4SXRW5OWmwhcea8fRXPp1Fz4dAvEeaQ3
	5Ky190ilJkIwgBVulF3kAqorIpTNSCwuEKng==;
Received: by exim-smtp-84d6fb566c-wglvt with esmtpa (envelope-from <skyline@mail.ru>)
	id 1xFFPF-000000001hg-2uXN; Fri, 09 Oct 2026 21:33:22 +0300
From: Konstantin Meshkov <skyline@mail.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Aleksander Jan Bajkowski <olek2@wp.pl>
Subject:
 Re: [PATCH net-next] net: phy: marvell: add LED support for 88E1116R PHY
Date: Fri, 09 Oct 2026 21:33:21 +0300
Message-ID: <179157080151.2919349.14930375926277142714@mail.ru>
In-Reply-To: <1bef1633-8213-476f-a019-f29a71553e09@lunn.ch>
References: <179152610952.2918676.6625057760354797023@mail.ru>
 <1bef1633-8213-476f-a019-f29a71553e09@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD968B159B7CE59A0BE839AFA9BDD930B8FADE3061D615233CE182A05F53808504090EB24609BF31F213DE06ABAFEAF6705E581C46925C9F303C92BF50CAFD2D6264ED41D986C17A953
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AB5815F4DE05345AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F88016AB904663428638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B253C75DEF4E44AF3B2E070BE324C7D3C4B964E0D86F22F0CBBB0A4F435E46E6718B35066C979671628AA50765F79006370D9A29B7FD16D1239FA2833FD35BB23D27C277FBC8AE2E8B55B19328CBC4F849A471835C12D1D977C4224003CC836476EB9C41850244470149FD398EE364050FB28585415E75ADA9040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006377AA2284B41911753EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A519FF7EA91328DAD35002B1117B3ED696F0D39B8DC1DA691569995D676B7B4CBE823CB91A9FED034534781492E4B8EEADADEF88395FA75C5FBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6598D17824D78122CA9C149431AA5F3AE4C16E367EDE86A3108BE1A5722693E7BA88B56DE7E7E65C08BB8341EE9D5BE9A0A09C25327078F53203B3D34973F4D6BD2FD3A9E3EEFF9D0576536EB022892E5344C41F94D744909CEF050418E73B5114343AC56E63459EDF0964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWH5tNqQj7XulDLEd9SnCO68=
X-Mailru-Sender: 7F28D27DF3217653F22F657F8252CA87C84551CB0FCEEC19B951B70A5BD4BD8E3C2923B751FF33D7D3C3B9E8BF9E2370E2E7FBE4C8C559FA08335C02508E532CFD0FAA000577B61F3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B45D890D6ED43546528841C2FD58021E0538E7744A242C81F668F3CF0E9FE49B6936D86992DF37BCF380F5673DBCD9B91D9F16D0DE78AFE8392F3F1EDFD6DB5E2766139748607E89BF
X-7FA49CB5: 0D63561A33F958A5752768D39F8332755002B1117B3ED6964215AEDC06C66C9438F1085A36400C8202ED4CEA229C1FA827C277FBC8AE2E8B151349A97B1D58DE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8azJwwEpi/pKF2ATidM7B36U=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

> I've not be tracking. Is this merged already? If not, please resubmit
> once it has been.

Not merged yet. It is still under review as "[PATCH net-next v2] net:
phy: marvell: add support for PHY LEDs polarity modes" (patchwork
14842707). I'll resubmit once it lands.

Thanks,
Konstantin
