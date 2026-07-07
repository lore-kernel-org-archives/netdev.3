Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E873BE642;
	Tue,  7 Jul 2026 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407572; cv=none; b=U1YHK8XjUhxA8Y1pXVH8Fm+nD83oj8TXSZIbgNQuvECrtNQTbTKlBtUsiVxhBjpJ9I350c5yVyXs7trioEIuyTg80AcTThwd455ToOAlkPIntXAg0YDJI6Mg+7JJlXdgSjvoZJHLR5I5P2rxL8tvud2nvX+fvHfm60308uTNsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407572; c=relaxed/simple;
	bh=J5z4v8MnX37yvRsBRkrgJ7RXFCTxbHS1dIRgegQB26U=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=SVtV9ZlG0siUCNW7r/KEQ9FDeZ6axKf+nl5yjo4npZ680SHBAttJGW6mmOAdP8Q3yOQQOJHNgiYRLC8F6LNfxBXEuBGr6I3yka6sOA5zXcJJ866BFPOvlXLgfR/3F+bPzgG9n1XKMv+i3ZzjpeIaUO/TGQ/oFyxY67N8tutOkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=gUqA1FTH; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="gUqA1FTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783407369;
	bh=kaPGdKlGO3D+peQmYigaO6QLSP3edbFA8eMgoOpcNKI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=gUqA1FTHPEG8EOihHgfi4S46ixfVwWuEhwaIGk12dZXa1Q6q0/NBTneYiRU0jaegy
	 n5ZdVJAtYbka1LfFD+vvIZIA3SiqGeT1N4A7oyqYbJK7VqAsmM12ZDGz28FXtqqO2h
	 sINyMwK+N3NAPC7oKD/8BNNZ8PLRmpMX6NBlrOeM=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6676u7Zc022889
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 7 Jul 2026 08:56:08 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------MskE5ndfay3xkFhLGVVkdWqb"
Message-ID: <527f81a7-05da-4c01-b4fa-aa090c6f57ce@tu-dortmund.de>
Date: Tue, 7 Jul 2026 08:56:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
 <akvhhy_JpH64KrcL@karahi.librecast.net>
 <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
Content-Language: en-US
In-Reply-To: <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>

This is a multi-part message in MIME format.
--------------MskE5ndfay3xkFhLGVVkdWqb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 08:52, Simon Schippers wrote:
> Brett, can you try the two attached patches here with iperf3?
> I think testing with 8 and 16 threads is enough, so where there is a
> regression.
> 
> The two patches are about time when to wake:
> Currently we wake after consuming half the internal ring buffer.
> One of the attached patches wakes after 2 cachelines (128 of 1000
> packets) and the other one just wakes once the ring buffer is empty.
> 
> This would really help :)

Whoops send you the wrong patch (the opt-in patch again), here
is the wake on empty patch.

--------------MskE5ndfay3xkFhLGVVkdWqb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tun-set-waking-threshold-to-ptr_ring_empty.patch"
Content-Disposition: attachment;
 filename="0001-tun-set-waking-threshold-to-ptr_ring_empty.patch"
Content-Transfer-Encoding: base64

RnJvbSBhNDM0MzkyMmU2MzVjYjFjYWIwMTdiMmU4NWNkZDJlNjA2Y2I2NjdhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBTY2hpcHBlcnMgPHNpbW9uLnNjaGlwcGVy
c0B0dS1kb3J0bXVuZC5kZT4KRGF0ZTogVHVlLCA3IEp1bCAyMDI2IDA4OjM4OjMxICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gdHVuOiBzZXQgd2FraW5nIHRocmVzaG9sZCB0byBwdHJfcmlu
Z19lbXB0eSgpCgpPbmx5IHdha2Ugb25jZSB0aGUgcHRyX3JpbmcgaXMgZW1wdHksIHdoaWNo
IHJlc3VsdHMgaW4gbGF0ZXIgYW5kIGxlc3MKY2FsbHMgb2YgbmV0aWZfdHhfd2FrZV9xdWV1
ZSgpLgotLS0KIGRyaXZlcnMvbmV0L3R1bi5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jCmluZGV4IGZmYmU2ZjEzZmIxZi4uYWNiYWZk
MzlmM2FlIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC90dW4uYworKysgYi9kcml2ZXJzL25l
dC90dW4uYwpAQCAtMjE1OCw4ICsyMTU4LDcgQEAgc3RhdGljIHZvaWQgX190dW5fd2FrZV9x
dWV1ZShzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLAogCXNtcF9tYigpOwogCWlmIChuZXRpZl90
eF9xdWV1ZV9zdG9wcGVkKHR4cSkpIHsKIAkJdGZpbGUtPmNvbnNfY250ICs9IGNvbnN1bWVk
OwotCQlpZiAodGZpbGUtPmNvbnNfY250ID49IHRmaWxlLT50eF9yaW5nLnNpemUgLyAyIHx8
Ci0JCSAgICBfX3B0cl9yaW5nX2VtcHR5KCZ0ZmlsZS0+dHhfcmluZykpIHsKKwkJaWYgKF9f
cHRyX3JpbmdfZW1wdHkoJnRmaWxlLT50eF9yaW5nKSkgewogCQkJbmV0aWZfdHhfd2FrZV9x
dWV1ZSh0eHEpOwogCQkJdGZpbGUtPmNvbnNfY250ID0gMDsKIAkJfQotLSAKMi40My4wCgo=


--------------MskE5ndfay3xkFhLGVVkdWqb--
