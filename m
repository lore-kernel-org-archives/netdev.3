Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132937A4B5;
	Tue, 17 Mar 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790125; cv=none; b=FdzyKAkhhLOUlXgKp0ktaIOgsJxWfcpnFs6dIiX0H7MoDKjxgwvx/Nek6lWdYs0DNKSmLz3eIl49THeJGnAI2hUoGoUsCsQMJwBeX+zdzR8KDVzT69TJ2U0xQmsWBcnXefnvsL+yz+7731gWZsjcbUoEG6qW3IrX6oULUR0d7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790125; c=relaxed/simple;
	bh=4/1y+WO1qwqKOBj5sXjwb9OHDtScb9JLjDVrKP7JM7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTTEXsARSotJ6yeYVOOEUwjJs1E5zyZAaJIHTKcI/MamNkeAKFq7RQ2+g19P7eaTeLplXitGqbqM6NuGavJl0Z41jsAqGu/hiX7VcxP8BzY6xb32Iqt8hW3+GsaqEsOrDYPVs+hG7plMo/5/a96ttemAPBUvWqG0JfLlhyE5F3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhoqusmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhoqusmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429AFC19425;
	Tue, 17 Mar 2026 23:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790124;
	bh=4/1y+WO1qwqKOBj5sXjwb9OHDtScb9JLjDVrKP7JM7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhoqusmG8/XNQFyYucJvXXUXf0DjW4fcxdMdfQEXlKWliZjfyQk6BTLY6hyKUnXL6
	 YyqWAp5q72+UbhNjFHih7vOEC+9TNSRIzXyATVwkrcVbAk7tTncMmucVb62yFwglHG
	 KNfA9Q8nQb343NWs1nH6Jz5uf175r65v1uck0jd9GJDlD44zbs90iaidIhM2KQ2C5s
	 z7UBKWLsk0c58Ou0u0qSRVcPixlpZOfa5cy+Y1gHoTTetJAZlXf/B2s8Atof1Hd0xW
	 z/50TRdL079U8kmgPWwUwzKQGBvPNww3zMWMPATJaEZ0sgoLa0ePs3Hi9pJ9zZAxIg
	 Xc25ukTldEniQ==
Date: Tue, 17 Mar 2026 16:28:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>, Mark Brown
 <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] regmap: mdio: make it depend on PHYLIB
Message-ID: <20260317162843.4cc4b57a@kernel.org>
In-Reply-To: <a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
	<a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 17:48:43 +0100 Heiner Kallweit wrote:
>  config REGMAP_MDIO
>  	tristate
> -	select MDIO_BUS
> +	depends on PHYLIB

The REGMAP_MDIO symbol seems to have no user in the first place?
I'd have expected any driver that practically needs it to select it.
What am I missing?
