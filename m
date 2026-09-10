Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F143C04D
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028149; cv=none; b=tQEudI2W0WxKkUGENPNH/KvQ/RhMp5hLkrOOonEwX+wSsm+JO6ZjalhkQN6Q/6HN1NIU90XZwSzbmVGUcFiDjkIzdX4mX3jtN7ey69QAyj2uNDYlnTBrYTbyxqJqhsEBRrQXG3RgvjrEsxUfk03+NtRlJRNjO4RMA6wV0mTB38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028149; c=relaxed/simple;
	bh=oFqtJ5EmgLf6Ze95TtwfjG5mlQjaQOcAOwGTGPesNNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK4236hzoHJp+Q+cw2L6FEucNBFdKzCAXRVBlBjnsR7IlbZg8YeFgHK8Rru546I9s2/OtA4COw/wx0BVWokmTrB1UzKJ/teLysXiKdWsZ4QBadIBXaitibyypPvPowrJmQQ9lc5gIOEsyH5WCmx3FhlZnfHF/2av6xViSjj3+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k6x+pe1q; arc=none smtp.client-ip=95.215.58.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k6x+pe1q"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oFqtJ5EmgLf6Ze95TtwfjG5mlQjaQOcAOwGTGPesNNY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789028143; v=1; x=1789632943;
 b=k6x+pe1qnOl9YVOTuuTm9UIpyxZ/JLoJjKo2a9rx6cqoVX1N0yWO1Jjt4yKL6+dEBUQx9y95
 rFnChD6Wzi5NmivHKztNJ4CB+/+KITm77VemgncPLTWSj/ZQ8ez2Gpi8SJMeO5L9c73w4MzCBz0
 BXwi5e/dffeuuXqZOoB/OXAA=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f7a365cfa6531857;
	Thu, 10 Sep 2026 08:15:43 +0000
X-Mizu-Trace-ID: f7a365cfa6531857
X-Migadu-Flow: FLOW_OUT
Date: Thu, 10 Sep 2026 16:15:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Janis Edvarts Lacis <janislacis06@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: vlan: fix vlan name truncation
Message-ID: <aqJnJBNbcv1LTV_7@fedora>
References: <20260904210024.263220-1-janislacis06@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904210024.263220-1-janislacis06@gmail.com>

On Sat, Sep 05, 2026 at 12:00:24AM +0300, Janis Edvarts Lacis wrote:
> register_vlan_device() from net/8021q/vlan.c sets name based on a field
> name_type from struct vlan_net. If name_type is VLAN_NAME_TYPE_RAW_PLUS_VID
> or VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD, register_vlan_device() sets vlan
> device's name to the actual net_device's name and adds vid at the end of
> this name separated by a dot.
> 
> Network interface's name is limited to at most 16 characters, including NUL.
> Therefore, if the real_dev->name is long enough, then adding the vid
> at the end of this name can lead to the result exceeding 16 bytes which
> leads to a truncated name for the vlan device created in register_vlan_device().
> 
> This patch fixes the issue by returning -ENAMETOOLONG from
> register_vlan_device() if the newly created name does not fit in 16
> bytes.
> 
> The bug was discovered when compiling with flag W=1, the following warning comes up:
> linux/net/8021q/vlan.c: In function ‘vlan_ioctl_handler’:
> linux/net/8021q/vlan.c:250:46: error: ‘%i’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 0 and 15 [-Werror=format-truncation=]
>   250 |                 snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
>       |                                              ^~
> In function ‘register_vlan_device’,
>     inlined from ‘vlan_ioctl_handler’ at linux/net/8021q/vlan.c:588:9:
> linux/net/8021q/vlan.c:250:42: note: directive argument in the range [0, 65535]
>   250 |                 snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
>       |                                          ^~~~~~~
> 
> Build & run the reproducer:
>     gcc poc.c -o poc
>     chmod +x poc.sh
>     ./poc.sh
> 
> ======BEGIN poc.sh======
> #!/usr/bin/env bash
> 
> sudo ip link add vlan1234567890 type dummy
> sudo ./poc
> 
> # name will not match the expected printed from poc.c on the unpatched
> # kernel, there will be no vlan interface at all on the patched one
> ip a
> ======END poc.sh========
> 
> ======BEGIN poc.c======
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/if.h>
> #include <linux/if_vlan.h>
> #include <linux/sockios.h>
> 
> #define IF_NAME "vlan1234567890"
> 
> int main()
> {
>     struct vlan_ioctl_args args = {
> 	.cmd = ADD_VLAN_CMD,
> 	.u.VID = 1234,
>     };
> 
>     strcpy(args.device1, IF_NAME);
> 
>     int fd = socket(AF_INET, SOCK_STREAM, 0);
>     if (fd < 0) {
> 	perror("socket");
> 	return 1;
>     }
> 
>     /* fails with -ENAMETOOLONG */
>     if (ioctl(fd, SIOCSIFVLAN, &args) < 0) {
> 	perror("SIOCSIFVLAN");
> 	close(fd);
> 	return 1;
>     }
> 
>     printf("Expected name: %s.%i\n", IF_NAME, args.u.VID);
>     close(fd);
>     return 0;
> }
> ======END poc.c========
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Janis Edvarts Lacis <janislacis06@gmail.com>
> ---
>  net/8021q/vlan.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 2d2efb877975..b51092d217de 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -220,7 +220,7 @@ static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
>  	struct net *net = dev_net(real_dev);
>  	struct vlan_net *vn = net_generic(net, vlan_net_id);
>  	char name[IFNAMSIZ];
> -	int err;
> +	int err, len;
>  
>  	if (vlan_id >= VLAN_VID_MASK)
>  		return -ERANGE;
> @@ -234,7 +234,9 @@ static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
>  	switch (vn->name_type) {
>  	case VLAN_NAME_TYPE_RAW_PLUS_VID:
>  		/* name will look like:	 eth1.0005 */
> -		snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
> +		len = snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
> +		if (len >= sizeof(name))
> +			err = -ENAMETOOLONG;
>  		break;
>  	case VLAN_NAME_TYPE_PLUS_VID_NO_PAD:
>  		/* Put our vlan.VID in the name.
> @@ -246,7 +248,9 @@ static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
>  		/* Put our vlan.VID in the name.
>  		 * Name will look like:	 eth0.5
>  		 */
> -		snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
> +		len = snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
> +		if (len >= sizeof(name))
> +			err = -ENAMETOOLONG;
>  		break;
>  	case VLAN_NAME_TYPE_PLUS_VID:
>  		/* Put our vlan.VID in the name.
> @@ -256,6 +260,9 @@ static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
>  		snprintf(name, IFNAMSIZ, "vlan%.4i", vlan_id);
>  	}
>  
> +	if (err)
> +		return err;
> +
>  	new_dev = alloc_netdev(sizeof(struct vlan_dev_priv), name,
>  			       NET_NAME_UNKNOWN, vlan_setup);
>  
> -- 
> 2.43.0
> 

Nice catch!

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
